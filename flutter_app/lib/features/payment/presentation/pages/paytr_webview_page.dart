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
/// - Kart numarası girildikten sonra kredi/banka kartı tespiti yapar
/// - Kredi kartı ise taksit seçeneklerini gösterir
/// - Seçilen taksit için yeni token alır ve PayTR'ye gönderir
class PayTRWebViewPage extends ConsumerStatefulWidget {
  final PayTRInitResponse paytrResponse;

  const PayTRWebViewPage({
    super.key,
    required this.paytrResponse,
  });

  @override
  ConsumerState<PayTRWebViewPage> createState() => _PayTRWebViewPageState();
}

class _PayTRWebViewPageState extends ConsumerState<PayTRWebViewPage> {
  late WebViewController _controller;
  bool _isLoading = true;
  bool _formSubmitted = false;
  bool _isRefreshingToken = false;

  // Kart formu değerleri
  final _cardOwnerController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _emailController = TextEditingController();

  // Taksit seçimi
  int _selectedInstallment = 0;
  bool _isCreditCard = false;
  String _cardBrand = '';
  
  // Güncel PayTR fields (taksit değişince güncellenir)
  late Map<String, String> _currentFields;
  late String _currentAction;

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
    ref.read(checkoutProvider.notifier).paymentFailed('Ödeme işlemi başarısız oldu');
    if (mounted) {
      Navigator.of(context).pop(false);
    }
  }

  /// Kart numarasının ilk 6 hanesine (BIN) göre kart tipini tespit et
  void _detectCardType(String cardNumber) {
    final cleanNumber = cardNumber.replaceAll(' ', '');
    
    if (cleanNumber.length < 6) {
      setState(() {
        _isCreditCard = false;
        _cardBrand = '';
        if (_selectedInstallment != 0) {
          _selectedInstallment = 0;
        }
      });
      return;
    }

    final firstDigit = cleanNumber[0];
    final firstTwo = cleanNumber.substring(0, 2);
    final firstFour = cleanNumber.substring(0, 4);

    String brand = '';
    bool isCreditCard = true;

    // Kart markası tespiti
    if (firstDigit == '4') {
      brand = 'Visa';
    } else if (['51', '52', '53', '54', '55'].contains(firstTwo) ||
        (int.tryParse(firstTwo) ?? 0) >= 22 && (int.tryParse(firstTwo) ?? 0) <= 27) {
      brand = 'Mastercard';
    } else if (firstTwo == '34' || firstTwo == '37') {
      brand = 'American Express';
    } else if (firstFour == '9792') {
      brand = 'Troy';
    }

    // Türkiye'deki yaygın banka kartı BIN'leri
    final debitBinPrefixes = [
      '979201', '979202', '979203', '979204', '979205', // Troy Banka Kartları
      '650000', '650001', '650002', // Maestro
      '676770', '676771', '676772', '676773', '676774', // Maestro TR
      '639000', '639001', '639002', // Banka kartları
    ];

    // 6 haneli BIN kontrolü
    if (cleanNumber.length >= 6) {
      final bin6 = cleanNumber.substring(0, 6);
      for (final prefix in debitBinPrefixes) {
        if (bin6.startsWith(prefix.substring(0, prefix.length.clamp(0, 6)))) {
          isCreditCard = false;
          break;
        }
      }
      
      // Troy kartları için ek kontrol - genellikle 979200-979299 arası banka kartı
      if (bin6.startsWith('9792')) {
        // Troy BIN'leri genellikle banka kartı olarak kullanılıyor
        // Ama bazı Troy kredi kartları da var, bu yüzden default olarak
        // banka kartı kabul ediyoruz
        isCreditCard = false;
      }
    }

    setState(() {
      _isCreditCard = isCreditCard;
      _cardBrand = brand;
      // Banka kartıysa taksit seçimini sıfırla
      if (!isCreditCard && _selectedInstallment != 0) {
        _selectedInstallment = 0;
      }
    });
  }

  /// Taksit seçildiğinde token yenile
  Future<void> _onInstallmentSelected(int installment) async {
    if (installment == _selectedInstallment) return;
    
    setState(() {
      _selectedInstallment = installment;
      _isRefreshingToken = true;
    });

    try {
      final merchantOid = _currentFields['merchant_oid'];
      if (merchantOid == null || merchantOid.isEmpty) {
        throw Exception('Sipariş ID bulunamadı');
      }

      final paytrService = ref.read(paytrServiceProvider);
      final newResponse = await paytrService.refreshToken(
        merchantOid: merchantOid,
        installmentCount: installment,
      );

      setState(() {
        _currentFields = Map.from(newResponse.fields);
        _currentAction = newResponse.action;
        _isRefreshingToken = false;
      });
    } catch (e) {
      setState(() {
        _isRefreshingToken = false;
      });
      _showError('Taksit güncellenirken hata oluştu: $e');
    }
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
    body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; }
    .loading { display: flex; justify-content: center; align-items: center; height: 100vh; }
    .spinner { width: 50px; height: 50px; border: 3px solid #f3f3f3; border-top: 3px solid #FF6B00; border-radius: 50%; animation: spin 1s linear infinite; }
    @keyframes spin { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }
    p { text-align: center; color: #666; margin-top: 20px; }
  </style>
</head>
<body>
  <div class="loading">
    <div>
      <div class="spinner"></div>
      <p>Ödeme işleniyor...</p>
    </div>
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

    // Kart tipini tespit et
    _detectCardType(text);
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
    final paymentAmountStr = _currentFields['payment_amount'] ?? '0';
    final paymentAmountTL = double.tryParse(paymentAmountStr) ?? 0;
    final cardNumber = _cardNumberController.text.replaceAll(' ', '');

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tutar gösterimi
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.primaryOrange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.primaryOrange),
            ),
            child: Column(
              children: [
                const Text(
                  'Ödenecek Tutar',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  formatPrice(paymentAmountTL),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
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
            onChanged: _formatCardNumber,
            suffixWidget: _cardBrand.isNotEmpty
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _isCreditCard ? Colors.green.withOpacity(0.2) : Colors.blue.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      _isCreditCard ? '$_cardBrand Kredi' : '$_cardBrand Banka',
                      style: TextStyle(
                        color: _isCreditCard ? Colors.green : Colors.blue,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : null,
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

          // Taksit Seçimi (sadece kart numarası girildikten ve kredi kartı ise)
          if (cardNumber.length >= 6) _buildInstallmentSection(paymentAmountTL),
          const SizedBox(height: 24),

          // Ödeme Yap Butonu
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isRefreshingToken ? null : _submitPaymentForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryOrange,
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.grey[800],
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isRefreshingToken
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      'Ödemeyi Tamamla - ${formatPrice(paymentAmountTL)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 16),

          // Güvenlik notu
          Row(
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
          ),
        ],
      ),
    );
  }

  Widget _buildInstallmentSection(double totalAmount) {
    // Banka kartıysa
    if (!_isCreditCard) {
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
                _cardBrand.isNotEmpty
                    ? '$_cardBrand Banka Kartı ile tek çekim ödeme yapılacaktır'
                    : 'Banka kartı ile sadece tek çekim yapılabilir',
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

    // Kredi kartı - taksit seçeneklerini göster
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
              const Icon(Icons.calendar_month, color: AppTheme.primaryOrange, size: 20),
              const SizedBox(width: 8),
              Text(
                'Taksit Seçenekleri${_cardBrand.isNotEmpty ? ' ($_cardBrand)' : ''}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildInstallmentOption(0, 'Tek Çekim', totalAmount),
              _buildInstallmentOption(2, '2 Taksit', totalAmount / 2),
              _buildInstallmentOption(3, '3 Taksit', totalAmount / 3),
              _buildInstallmentOption(6, '6 Taksit', totalAmount / 6),
              _buildInstallmentOption(9, '9 Taksit', totalAmount / 9),
              _buildInstallmentOption(12, '12 Taksit', totalAmount / 12),
            ],
          ),
          if (_selectedInstallment > 0) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.primaryOrange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: AppTheme.primaryOrange, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '$_selectedInstallment taksit seçildi - Aylık ${formatPrice(totalAmount / _selectedInstallment)}',
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

  Widget _buildInstallmentOption(int count, String label, double monthlyAmount) {
    final isSelected = _selectedInstallment == count;

    return GestureDetector(
      onTap: _isRefreshingToken ? null : () => _onInstallmentSelected(count),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primaryOrange
              : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? AppTheme.primaryOrange
                : Colors.white.withOpacity(0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white70,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
            ),
            if (count > 0) ...[
              const SizedBox(height: 2),
              Text(
                '${formatPrice(monthlyAmount)}/ay',
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.white54,
                  fontSize: 10,
                ),
              ),
            ],
          ],
        ),
      ),
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
              ref.read(checkoutProvider.notifier).paymentFailed('Ödeme iptal edildi');
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
