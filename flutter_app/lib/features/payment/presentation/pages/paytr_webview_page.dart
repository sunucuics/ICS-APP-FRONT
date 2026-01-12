import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/price_utils.dart';
import '../../data/paytr_service.dart';
import '../../models/paytr_models.dart';
import '../../providers/checkout_provider.dart';

/// PayTR WebView Ödeme Sayfası
///
/// PayTR Direct API ile ödeme almak için WebView kullanır.
/// - Kart numarası girildikten sonra backend BIN API ile kart tipini tespit eder
/// - Kredi kartı ise peşin ve 3 taksit seçeneklerini gösterir (%15 vade farkı ile)
/// - Seçilen taksit için yeni token alır ve PayTR'ye gönderir
class PayTRWebViewPage extends ConsumerStatefulWidget {
  final PayTRInitResponse paytrResponse;

  /// Taksit değişikliğinde yeni init için gerekli bilgiler
  final List<BasketItem> basketItems;
  final String email;
  final String userName;
  final String userAddress;
  final String userPhone;

  const PayTRWebViewPage({
    super.key,
    required this.paytrResponse,
    required this.basketItems,
    required this.email,
    required this.userName,
    required this.userAddress,
    required this.userPhone,
  });

  @override
  ConsumerState<PayTRWebViewPage> createState() => _PayTRWebViewPageState();
}

class _PayTRWebViewPageState extends ConsumerState<PayTRWebViewPage> {
  late WebViewController _controller;
  bool _isLoading = true;
  bool _formSubmitted = false;
  bool _isRefreshingToken = false;
  bool _isFetchingQuote = false;

  // Kart formu değerleri
  final _cardOwnerController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _emailController = TextEditingController();

  // Taksit seçimi (Backend'den alınır)
  int _selectedInstallment = 0;
  InstallmentQuoteResponse? _installmentQuote;
  String _currentBin = '';

  // Güncel PayTR fields (taksit değişince güncellenir)
  late Map<String, String> _currentFields;
  late String _currentAction;

  // Peşin tutar (sepet toplamı)
  double _baseAmount = 0;

  @override
  void initState() {
    super.initState();
    _initWebView();

    // Initial fields
    _currentFields = Map.from(widget.paytrResponse.fields);
    _currentAction = widget.paytrResponse.action;

    // Email'i fields'dan al
    final email = widget.paytrResponse.fields['email'] ?? '';
    _emailController.text = email;

    // Peşin tutarı al
    final paymentAmountStr = widget.paytrResponse.fields['payment_amount'] ?? '0';
    _baseAmount = double.tryParse(paymentAmountStr) ?? 0;
  }

  @override
  void dispose() {
    _cardOwnerController.dispose();
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _initWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() => _isLoading = true);
          },
          onPageFinished: (url) {
            setState(() => _isLoading = false);
            _checkPaymentResult(url);
          },
          onNavigationRequest: (request) {
            _checkPaymentResult(request.url);
            return NavigationDecision.navigate;
          },
        ),
      );
  }

  void _checkPaymentResult(String url) {
    final uri = Uri.parse(url);
    final path = uri.path.toLowerCase();

    if (path.contains('/payment/success') ||
        path.contains('/paytr/success') ||
        path.contains('/odeme/basarili')) {
      _handlePaymentSuccess();
    } else if (path.contains('/payment/fail') ||
        path.contains('/paytr/fail') ||
        path.contains('/odeme/basarisiz')) {
      _handlePaymentFailure();
    }
  }

  Future<void> _handlePaymentSuccess() async {
    // Ödeme doğrulamasını bekle
    await ref.read(checkoutProvider.notifier).verifyPayment();

    if (mounted) {
      Navigator.of(context).pop(true);
    }
  }

  void _handlePaymentFailure() {
    ref
        .read(checkoutProvider.notifier)
        .paymentFailed('Ödeme işlemi başarısız oldu');
    if (mounted) {
      Navigator.of(context).pop(false);
    }
  }

  /// Kart numarası değiştiğinde backend'den taksit seçeneklerini al
  Future<void> _onCardNumberChanged(String value) async {
    _formatCardNumber(value);

    final cleanNumber = _cardNumberController.text.replaceAll(' ', '');

    // 6 haneden az ise temizle
    if (cleanNumber.length < 6) {
      if (_installmentQuote != null || _currentBin.isNotEmpty) {
        setState(() {
          _installmentQuote = null;
          _currentBin = '';
          _selectedInstallment = 0;
        });
      }
      return;
    }

    final bin = cleanNumber.substring(0, cleanNumber.length >= 8 ? 8 : 6);

    // Aynı BIN ise tekrar sorma
    if (bin == _currentBin) return;

    setState(() {
      _currentBin = bin;
      _isFetchingQuote = true;
    });

    try {
      final paytrService = ref.read(paytrServiceProvider);
      final quote = await paytrService.getInstallmentQuote(
        binNumber: bin,
        amountTl: _baseAmount,
      );

      if (mounted) {
        setState(() {
          _installmentQuote = quote;
          _isFetchingQuote = false;
          // Debit kart ise taksit seçimini sıfırla
          if (quote.isDebitCard && _selectedInstallment != 0) {
            _selectedInstallment = 0;
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _installmentQuote = null;
          _isFetchingQuote = false;
          _selectedInstallment = 0;
        });
      }
    }
  }

  /// Taksit seçildiğinde token yenile
  Future<void> _onInstallmentSelected(int installment) async {
    if (installment == _selectedInstallment) return;
    if (installment != 0 && installment != 3) return;

    // 3 taksit için kredi kartı kontrolü
    if (installment == 3) {
      if (_installmentQuote == null || !_installmentQuote!.has3Installment) {
        _showError('Bu kart ile taksitli ödeme yapılamaz');
        return;
      }
    }

    setState(() {
      _selectedInstallment = installment;
      _isRefreshingToken = true;
    });

    try {
      final merchantOid = _currentFields['merchant_oid'];
      if (merchantOid == null || merchantOid.isEmpty) {
        throw Exception('Ödeme oturumu bulunamadı');
      }

      // refreshToken yerine yeni initDirectPayment çağır
      // Çünkü backend payment session'ı Firestore'da saklamıyor
      final paytrService = ref.read(paytrServiceProvider);
      final request = PayTRInitRequest(
        merchantOid: merchantOid,
        email: widget.email,
        paymentAmount: _baseAmount, // Peşin tutar
        installmentCount: installment,
        userName: widget.userName,
        userAddress: widget.userAddress,
        userPhone: widget.userPhone,
        basket: widget.basketItems,
        binNumber: installment == 3 ? _currentBin : null,
      );

      final newResponse = await paytrService.initDirectPayment(request);

      setState(() {
        _currentFields = Map.from(newResponse.fields);
        _currentAction = newResponse.action;
        _isRefreshingToken = false;
      });
    } catch (e) {
      setState(() {
        _selectedInstallment = 0; // Hata durumunda peşine dön
        _isRefreshingToken = false;
      });
      _showError('Taksit güncellenirken hata oluştu: ${_parseError(e.toString())}');
    }
  }

  String _parseError(String error) {
    if (error.contains('bin_number zorunludur')) {
      return 'Kart numarası gereklidir';
    }
    if (error.contains('Banka kartı') || error.contains('debit')) {
      return 'Banka kartı ile taksit yapılamaz';
    }
    if (error.contains('taksit programına uygun değil')) {
      return 'Bu kart ile taksit yapılamaz';
    }
    return error.replaceAll('Exception:', '').trim();
  }

  /// HTML form oluştur ve WebView'a yükle
  void _submitPaymentForm() {
    if (!_validateForm()) return;
    if (_isRefreshingToken) {
      _showError('Lütfen bekleyin, taksit bilgisi güncelleniyor...');
      return;
    }

    final expiryParts = _expiryController.text.split('/');
    final expiryMonth = expiryParts.isNotEmpty ? expiryParts[0].trim() : '';
    final expiryYear = expiryParts.length > 1 ? expiryParts[1].trim() : '';

    final html = '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; background: #000; }
    .loading { display: flex; justify-content: center; align-items: center; height: 100vh; flex-direction: column; }
    .spinner { width: 50px; height: 50px; border: 3px solid #333; border-top: 3px solid #FF6B00; border-radius: 50%; animation: spin 1s linear infinite; }
    @keyframes spin { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }
    p { text-align: center; color: #999; margin-top: 20px; }
  </style>
</head>
<body>
  <div class="loading">
    <div class="spinner"></div>
    <p>Ödeme işleniyor...</p>
  </div>
  <form id="paytr_form" method="POST" action="$_currentAction" style="display:none;">
    ${_buildHiddenInputs(_currentFields)}
    <input type="hidden" name="cc_owner" value="${_escapeHtml(_cardOwnerController.text)}">
    <input type="hidden" name="card_number" value="${_escapeHtml(_cardNumberController.text.replaceAll(' ', ''))}">
    <input type="hidden" name="expiry_month" value="${_escapeHtml(expiryMonth)}">
    <input type="hidden" name="expiry_year" value="${_escapeHtml(expiryYear)}">
    <input type="hidden" name="cvv" value="${_escapeHtml(_cvvController.text)}">
  </form>
  <script>
    document.getElementById('paytr_form').submit();
  </script>
</body>
</html>
''';

    setState(() {
      _formSubmitted = true;
    });

    _controller.loadHtmlString(html);
  }

  String _buildHiddenInputs(Map<String, String> fields) {
    return fields.entries
        .map((e) =>
            '<input type="hidden" name="${_escapeHtml(e.key)}" value="${_escapeHtml(e.value)}">')
        .join('\n    ');
  }

  String _escapeHtml(String text) {
    return text
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#39;');
  }

  bool _validateForm() {
    if (_cardOwnerController.text.trim().isEmpty) {
      _showError('Kart sahibi adı gerekli');
      return false;
    }
    if (_cardNumberController.text.replaceAll(' ', '').length < 15) {
      _showError('Geçerli bir kart numarası girin');
      return false;
    }
    if (!_expiryController.text.contains('/') ||
        _expiryController.text.length < 5) {
      _showError('Geçerli bir son kullanma tarihi girin (AA/YY)');
      return false;
    }
    if (_cvvController.text.length < 3) {
      _showError('Geçerli bir CVV girin');
      return false;
    }
    return true;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.errorRed,
      ),
    );
  }

  void _formatCardNumber(String value) {
    final text = value.replaceAll(' ', '');
    final buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' ');
      }
      buffer.write(text[i]);
    }

    final formatted = buffer.toString();
    if (formatted != value) {
      _cardNumberController.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }
  }

  void _formatExpiry(String value) {
    final text = value.replaceAll('/', '');

    if (text.length >= 2) {
      final month = text.substring(0, 2);
      final year = text.length > 2 ? text.substring(2) : '';
      final formatted = year.isNotEmpty ? '$month/$year' : month;

      if (formatted != value && value.length >= 2) {
        _expiryController.value = TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Ödeme'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => _showCancelDialog(),
        ),
      ),
      body: _formSubmitted ? _buildWebView() : _buildCardForm(),
    );
  }

  Widget _buildWebView() {
    return Stack(
      children: [
        WebViewWidget(controller: _controller),
        if (_isLoading)
          const Center(
            child: CircularProgressIndicator(
              color: AppTheme.primaryOrange,
            ),
          ),
      ],
    );
  }

  Widget _buildCardForm() {
    // Güncel ödenecek tutar (taksit seçimine göre)
    final paymentAmountStr = _currentFields['payment_amount'] ?? '0';
    final currentPaymentAmount = double.tryParse(paymentAmountStr) ?? 0;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tutar gösterimi
          _buildAmountCard(currentPaymentAmount),
          const SizedBox(height: 32),

          // Kart Bilgileri Başlığı
          const Text(
            'Kart Bilgileri',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Kart Sahibi
          _buildTextField(
            controller: _cardOwnerController,
            label: 'Kart Sahibinin Adı',
            hint: 'AHMET YILMAZ',
            icon: Icons.person,
            textCapitalization: TextCapitalization.characters,
          ),
          const SizedBox(height: 16),

          // Kart Numarası
          _buildTextField(
            controller: _cardNumberController,
            label: 'Kart Numarası',
            hint: '0000 0000 0000 0000',
            icon: Icons.credit_card,
            keyboardType: TextInputType.number,
            maxLength: 19,
            onChanged: _onCardNumberChanged,
            suffixWidget: _buildCardTypeBadge(),
          ),
          const SizedBox(height: 16),

          // Son Kullanma Tarihi ve CVV
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  controller: _expiryController,
                  label: 'Son Kullanma',
                  hint: 'AA/YY',
                  icon: Icons.calendar_today,
                  keyboardType: TextInputType.number,
                  maxLength: 5,
                  onChanged: _formatExpiry,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTextField(
                  controller: _cvvController,
                  label: 'CVV',
                  hint: '000',
                  icon: Icons.lock,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  obscureText: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Taksit Seçimi
          _buildInstallmentSection(),
          const SizedBox(height: 24),

          // Ödeme Yap Butonu
          _buildPayButton(currentPaymentAmount),
          const SizedBox(height: 16),

          // Güvenlik notu
          _buildSecurityNote(),
        ],
      ),
    );
  }

  Widget _buildAmountCard(double amount) {
    final isInstallment = _selectedInstallment == 3;
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.primaryOrange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.primaryOrange),
      ),
      child: Column(
        children: [
          Text(
            isInstallment ? 'Toplam Ödenecek Tutar' : 'Ödenecek Tutar',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            formatPrice(amount),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (isInstallment && _installmentQuote?.taksit3Option != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '3 x ${formatPrice(_installmentQuote!.taksit3Option!.perInstallmentAmount)} / ay',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget? _buildCardTypeBadge() {
    if (_isFetchingQuote) {
      return const SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: AppTheme.primaryOrange,
        ),
      );
    }

    if (_installmentQuote == null) return null;

    final isCreditCard = _installmentQuote!.isCreditCard;
    final brand = _installmentQuote!.brand ?? '';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isCreditCard
            ? Colors.green.withOpacity(0.2)
            : Colors.blue.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        isCreditCard
            ? (brand.isNotEmpty ? '${brand.toUpperCase()} Kredi' : 'Kredi Kartı')
            : (brand.isNotEmpty ? '${brand.toUpperCase()} Banka' : 'Banka Kartı'),
        style: TextStyle(
          color: isCreditCard ? Colors.green : Colors.blue,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInstallmentSection() {
    final cleanNumber = _cardNumberController.text.replaceAll(' ', '');

    // Kart numarası yetersiz
    if (cleanNumber.length < 6) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Row(
          children: [
            Icon(Icons.info_outline, color: Colors.white.withOpacity(0.5), size: 20),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Taksit seçeneklerini görmek için kart numarasını girin',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      );
    }

    // BIN sorgulanıyor
    if (_isFetchingQuote) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppTheme.primaryOrange,
              ),
            ),
            SizedBox(width: 12),
            Text(
              'Taksit seçenekleri yükleniyor...',
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      );
    }

    // Debit kart veya taksit yok
    if (_installmentQuote == null ||
        _installmentQuote!.isDebitCard ||
        !_installmentQuote!.has3Installment) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blue.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            const Icon(Icons.info_outline, color: Colors.blue, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                _installmentQuote?.isDebitCard == true
                    ? 'Banka kartı ile sadece tek çekim yapılabilir'
                    : 'Bu kart ile sadece tek çekim yapılabilir',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Kredi kartı - Peşin ve 3 Taksit seçenekleri
    final pesinOption = _installmentQuote!.pesinOption;
    final taksit3Option = _installmentQuote!.taksit3Option;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.calendar_month,
                  color: AppTheme.primaryOrange, size: 20),
              const SizedBox(width: 8),
              Text(
                'Ödeme Seçenekleri${_installmentQuote?.brand != null ? ' (${_installmentQuote!.brand!.toUpperCase()})' : ''}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Peşin ve 3 Taksit seçenekleri yan yana
          Row(
            children: [
              // Peşin
              Expanded(
                child: _buildInstallmentCard(
                  isSelected: _selectedInstallment == 0,
                  title: 'PEŞİN',
                  totalAmount: pesinOption?.totalAmount ?? _baseAmount,
                  perMonth: null,
                  surchargePercent: 0,
                  onTap: () => _onInstallmentSelected(0),
                ),
              ),
              const SizedBox(width: 12),
              // 3 Taksit
              Expanded(
                child: _buildInstallmentCard(
                  isSelected: _selectedInstallment == 3,
                  title: '3 TAKSİT',
                  totalAmount: taksit3Option?.totalAmount ?? 0,
                  perMonth: taksit3Option?.perInstallmentAmount,
                  surchargePercent: taksit3Option?.ratePercent ?? 15,
                  onTap: () => _onInstallmentSelected(3),
                ),
              ),
            ],
          ),

          // Seçim bilgisi
          if (_selectedInstallment == 3 && taksit3Option != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.primaryOrange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle,
                      color: AppTheme.primaryOrange, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '3 taksit seçildi - Aylık ${formatPrice(taksit3Option.perInstallmentAmount)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInstallmentCard({
    required bool isSelected,
    required String title,
    required double totalAmount,
    required double? perMonth,
    required double surchargePercent,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: _isRefreshingToken ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primaryOrange.withOpacity(0.2)
              : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppTheme.primaryOrange
                : Colors.white.withOpacity(0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            // Başlık
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white70,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            // Toplam tutar
            Text(
              formatPrice(totalAmount),
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white70,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            // Aylık tutar (varsa)
            if (perMonth != null) ...[
              const SizedBox(height: 4),
              Text(
                '${formatPrice(perMonth)} x 3 ay',
                style: TextStyle(
                  color: isSelected ? Colors.white70 : Colors.white54,
                  fontSize: 12,
                ),
              ),
            ],
            // Vade farkı (varsa)
            if (surchargePercent > 0) ...[
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '+%${surchargePercent.toStringAsFixed(0)} vade farkı',
                  style: const TextStyle(
                    color: Colors.orange,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPayButton(double amount) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: (_isRefreshingToken || _isFetchingQuote)
            ? null
            : _submitPaymentForm,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryOrange,
          foregroundColor: Colors.white,
          disabledBackgroundColor: Colors.grey[800],
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: (_isRefreshingToken || _isFetchingQuote)
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                'Ödemeyi Tamamla - ${formatPrice(amount)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }

  Widget _buildSecurityNote() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.lock,
          size: 16,
          color: Colors.white.withOpacity(0.5),
        ),
        const SizedBox(width: 8),
        Text(
          '256-bit SSL ile korunan güvenli ödeme',
          style: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    TextCapitalization textCapitalization = TextCapitalization.none,
    int? maxLength,
    bool obscureText = false,
    void Function(String)? onChanged,
    Widget? suffixWidget,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      maxLength: maxLength,
      obscureText: obscureText,
      onChanged: onChanged,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: AppTheme.primaryOrange),
        suffixIcon: suffixWidget != null
            ? Padding(
                padding: const EdgeInsets.only(right: 12),
                child: suffixWidget,
              )
            : null,
        suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        labelStyle: const TextStyle(color: Colors.white70),
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
        counterText: '',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.primaryOrange),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
      ),
    );
  }

  void _showCancelDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text(
          'Ödemeyi İptal Et',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Ödeme işlemini iptal etmek istediğinizden emin misiniz?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Vazgeç'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ref
                  .read(checkoutProvider.notifier)
                  .paymentFailed('Ödeme iptal edildi');
              Navigator.pop(context, false);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.errorRed,
            ),
            child: const Text(
              'İptal Et',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
