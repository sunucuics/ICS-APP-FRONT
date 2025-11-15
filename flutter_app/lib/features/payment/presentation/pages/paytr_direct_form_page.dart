import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../core/models/paytr_model.dart';
import '../../../../core/services/snackbar_service.dart';
import '../../providers/payment_provider.dart';

/// PayTR Direct API form submission page
/// Creates local HTML form with PayTR fields and submits to PayTR
class PayTRDirectFormPage extends ConsumerStatefulWidget {
  final String checkoutId;
  final PayTRDirectInitResponse initResponse;

  const PayTRDirectFormPage({
    super.key,
    required this.checkoutId,
    required this.initResponse,
  });

  @override
  ConsumerState<PayTRDirectFormPage> createState() =>
      _PayTRDirectFormPageState();
}

class _PayTRDirectFormPageState extends ConsumerState<PayTRDirectFormPage> {
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _hasError = false;
  String? _errorMessage;
  String? _preparedHtml;
  bool _controllerReady = false;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  Future<void> _initializeWebView() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
      _errorMessage = null;
      _controllerReady = false;
    });

    try {
      final controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              if (progress == 100) {
                setState(() {
                  _isLoading = false;
                });
              }
            },
            onPageStarted: (String url) {
              setState(() {
                _isLoading = true;
                _hasError = false;
              });
            },
            onPageFinished: (String url) {
              setState(() {
                _isLoading = false;
              });
              _handleUrlChange(url);
            },
            onWebResourceError: (WebResourceError error) {
              setState(() {
                _isLoading = false;
                _hasError = true;
                _errorMessage = error.description;
              });
            },
          ),
        );

      _controller = controller;

      _preparedHtml = await _buildHTMLForm();
      if (!mounted) return;

      _controller.loadRequest(Uri.dataFromString(
        _preparedHtml!,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8'),
      ));

      if (!mounted) return;
      setState(() {
        _controllerReady = true;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _hasError = true;
        _errorMessage = error.toString();
      });
      debugPrint('PayTR form hazırlama hatası: $error');
    }
  }

  Future<String> _buildHTMLForm() async {
    final fields = widget.initResponse.fields;
    final action = widget.initResponse.action;
    final paymentAmountLabel =
        '${_formatAmount(_parseAmount(fields.paymentAmount))} TL Öde';
    final icsLogoBase64 =
        await _loadAssetAsBase64('assets/images/ics_logo.jpg');
    final securityLogosBase64 =
        await _loadAssetAsBase64('assets/images/tekparca-logolar-1.jpg');

    // Build HTML form with PayTR fields
    return '''
<!DOCTYPE html>
<html lang="tr">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Güvenli Ödeme - PayTR</title>
  <style>
:root {
  color-scheme: light dark;
  --primary-color: #FF6B35;
  --primary-gradient: #FF8C42;
  --bg-color: #F6F7F9;
  --surface-color: #FFFFFF;
  --surface-alt-color: #F1F3F4;
  --text-color: #111111;
  --text-muted: #5F6B7A;
  --outline-color: #E6E8EC;
  --shadow-color: rgba(17, 17, 17, 0.08);
  --error-color: #EF4444;
  --on-primary: #FFFFFF;
}

@media (prefers-color-scheme: dark) {
  :root {
    --bg-color: #0F1115;
    --surface-color: #171A20;
    --surface-alt-color: #2C2C2E;
    --text-color: #FFFFFF;
    --text-muted: #B7C1CE;
    --outline-color: #252A33;
    --shadow-color: rgba(0, 0, 0, 0.45);
  }
}

body {
  margin: 0;
  padding: 24px 16px;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
  background: var(--bg-color);
  color: var(--text-color);
  min-height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
}

.container {
  background: var(--surface-color);
  border-radius: 24px;
  padding: 28px;
  box-shadow: 0 32px 70px var(--shadow-color);
  width: 100%;
  max-width: 520px;
}

.header {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 12px;
  margin-bottom: 24px;
}

.header img.logo {
  width: 140px;
  height: auto;
  object-fit: contain;
}

.subtitle {
  margin: 0;
  color: var(--text-muted);
  font-size: 14px;
  text-align: center;
}

.form-group {
  margin-bottom: 20px;
}

.label-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 12px;
}

.form-group label {
  display: block;
  margin-bottom: 8px;
  color: var(--text-color);
  font-weight: 600;
  font-size: 14px;
}

.input-wrapper {
  position: relative;
}

.form-group input {
  width: 100%;
  padding: 14px 16px;
  border: 1px solid var(--outline-color);
  border-radius: 16px;
  font-size: 16px;
  transition: border-color 0.2s ease, box-shadow 0.2s ease;
  box-sizing: border-box;
  background-color: var(--surface-alt-color);
  color: var(--text-color);
}

.form-group input:focus {
  outline: none;
  border-color: var(--primary-color);
  box-shadow: 0 0 0 3px rgba(255, 107, 53, 0.2);
}

.card-brand {
  position: absolute;
  right: 16px;
  top: 50%;
  transform: translateY(-50%);
  font-size: 12px;
  font-weight: 600;
  padding: 4px 10px;
  border-radius: 12px;
  background: var(--surface-color);
  border: 1px solid var(--outline-color);
  color: var(--text-muted);
  letter-spacing: 0.5px;
  transition: all 0.2s ease;
}

.card-brand.visa { color: #1A1F71; border-color: #1A1F71; background: #EAF0FF; }
.card-brand.mastercard { color: #EB001B; border-color: #FF5F00; background: #FFF0F0; }
.card-brand.amex { color: #0A7BC2; border-color: #0A7BC2; background: #E3F2FD; }
.card-brand.troy { color: #0C9C76; border-color: #0C9C76; background: #E1FDF2; }
.card-brand.discover { color: #FF6A00; border-color: #FF6A00; background: #FFF3E7; }

.row {
  display: flex;
  gap: 12px;
  flex-wrap: wrap;
}

.row .form-group {
  flex: 1;
  min-width: 160px;
}

.help-icon {
  border: none;
  background: transparent;
  color: var(--text-muted);
  font-size: 18px;
  cursor: pointer;
  padding: 0;
  line-height: 1;
}

.tooltip {
  display: none;
  margin-top: 8px;
  background: var(--surface-alt-color);
  border: 1px solid var(--outline-color);
  border-radius: 16px;
  padding: 12px;
  font-size: 12px;
  color: var(--text-muted);
  box-shadow: 0 16px 36px var(--shadow-color);
}

.tooltip.active {
  display: flex;
  align-items: center;
  gap: 12px;
}

.card-illustration {
  width: 64px;
  height: 42px;
  border-radius: 10px;
  background: linear-gradient(135deg, #dce6f3 0%, #f5f8fc 100%);
  position: relative;
  box-shadow: inset 0 3px 6px rgba(0, 0, 0, 0.1);
}

.card-illustration::after {
  content: 'CVV';
  position: absolute;
  right: 8px;
  top: 12px;
  font-size: 10px;
  font-weight: 700;
  color: #1A202C;
  background: #FFFFFF;
  padding: 2px 6px;
  border-radius: 6px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.15);
}

#submitBtn {
  width: 100%;
  padding: 16px;
  background: linear-gradient(135deg, var(--primary-color), var(--primary-gradient));
  color: var(--on-primary);
  border: none;
  border-radius: 18px;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
  transition: transform 0.2s ease, box-shadow 0.2s ease;
  box-shadow: 0 18px 38px rgba(255, 107, 53, 0.35);
  margin-top: 8px;
}

#submitBtn:active {
  transform: translateY(1px);
}

.error {
  color: var(--error-color);
  font-size: 12px;
  margin-top: 6px;
  display: none;
}

.loader {
  display: none;
  text-align: center;
  margin-top: 20px;
}

.spinner {
  border: 4px solid rgba(0,0,0,0.08);
  border-top: 4px solid var(--primary-color);
  border-radius: 50%;
  width: 36px;
  height: 36px;
  animation: spin 1s linear infinite;
  margin: 0 auto;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

.security-note {
  text-align: center;
  font-size: 12px;
  color: var(--text-muted);
  margin-top: 16px;
}

.security-logos {
  display: flex;
  justify-content: center;
  margin-top: 12px;
}

.security-logos img {
  width: 100%;
  max-width: 220px;
  object-fit: contain;
  opacity: 0.9;
}

.footer {
  margin-top: 28px;
  text-align: center;
  font-size: 12px;
  color: var(--text-muted);
  letter-spacing: 0.3px;
}

.footer strong {
  color: var(--text-color);
}
  </style>
</head>
<body>
  <div class="container">
    <div class="header">
      <img class="logo" src="data:image/jpeg;base64,$icsLogoBase64" alt="ICS Logo">
      <p class="subtitle">Kart bilgilerinizi girin</p>
    </div>
    
    <form id="paymentForm" method="post" action="$action" accept-charset="utf-8">
      <!-- Hidden PayTR Fields -->
      <input type="hidden" name="merchant_id" value="${fields.merchantId}">
      <input type="hidden" name="user_ip" value="${fields.userIp}">
      <input type="hidden" name="merchant_oid" value="${fields.merchantOid}">
      <input type="hidden" name="email" value="${fields.email}">
      <input type="hidden" name="payment_type" value="${fields.paymentType}">
      <input type="hidden" name="payment_amount" value="${fields.paymentAmount}">
      <input type="hidden" name="currency" value="${fields.currency}">
      <input type="hidden" name="test_mode" value="${fields.testMode}">
      <input type="hidden" name="non_3d" value="${fields.non3d}">
      <input type="hidden" name="client_lang" value="${fields.clientLang}">
      <input type="hidden" name="merchant_ok_url" value="${fields.merchantOkUrl}">
      <input type="hidden" name="merchant_fail_url" value="${fields.merchantFailUrl}">
      <input type="hidden" name="user_name" value="${fields.userName}">
      <input type="hidden" name="user_address" value="${fields.userAddress}">
      <input type="hidden" name="user_phone" value="${fields.userPhone}">
      <input type="hidden" name="user_basket" value="${fields.userBasket}">
      <input type="hidden" name="installment_count" value="${fields.installmentCount}">
      <input type="hidden" name="debug_on" value="${fields.debugOn}">
      <input type="hidden" name="paytr_token" value="${fields.paytrToken}">
      ${fields.cardType != null ? '<input type="hidden" name="card_type" value="${fields.cardType}">' : ''}
      <input type="hidden" name="expiry_month" id="expiry_month_hidden">
      <input type="hidden" name="expiry_year" id="expiry_year_hidden">
      
      <!-- Card Input Fields -->
      <div class="form-group">
        <label for="cc_owner">Kart Üzerindeki İsim *</label>
        <input type="text" id="cc_owner" name="cc_owner" placeholder="ADI SOYADI" required>
        <div class="error" id="cc_owner_error"></div>
      </div>
      
      <div class="form-group">
        <label for="card_number">Kart Numarası *</label>
        <div class="input-wrapper">
          <input type="text" id="card_number" name="card_number" placeholder="1234 5678 9012 3456" maxlength="19" required>
          <span id="cardBrand" class="card-brand">KART</span>
        </div>
        <div class="error" id="card_number_error"></div>
      </div>
      
      <div class="row">
        <div class="form-group">
          <label for="expiry">Son Kullanma Tarihi *</label>
          <div class="input-wrapper">
            <input type="text" id="expiry" placeholder="AA / YY" maxlength="7" required>
          </div>
          <div class="error" id="expiry_error"></div>
        </div>
        
        <div class="form-group">
          <div class="label-row">
            <label for="cvv">CVV *</label>
            <button type="button" class="help-icon" id="cvvHelp" aria-label="CVV nedir?">?</button>
          </div>
          <div class="input-wrapper">
            <input type="text" id="cvv" name="cvv" placeholder="123" maxlength="4" required>
          </div>
          <div class="error" id="cvv_error"></div>
          <div class="tooltip" id="cvvTooltip">
            <div class="card-illustration"></div>
            <div>
              <strong>CVV / CVC</strong>
              <p>Kartınızın arka yüzündeki 3 haneli güvenlik kodudur.</p>
            </div>
          </div>
        </div>
      </div>
      
      <div class="form-group">
        <label for="email_visible">E-posta *</label>
        <input type="email" id="email_visible" name="email" value="${fields.email}" required>
        <div class="error" id="email_error"></div>
      </div>
      
      <button type="submit" id="submitBtn">$paymentAmountLabel</button>
      <p class="security-note">Ödemeleriniz 256-bit SSL sertifikası ile korunmaktadır.</p>
      <div class="security-logos">
        <img src="data:image/jpeg;base64,$securityLogosBase64" alt="Güvenlik logoları">
      </div>
      
      <div class="loader" id="loader">
        <div class="spinner"></div>
        <p>İşleminiz gerçekleştiriliyor...</p>
      </div>
    </form>
    <div class="footer">
      Powered by <strong>PayTR</strong>
    </div>
  </div>
  
  <script>
const cardNumberInput = document.getElementById('card_number');
const cardBrand = document.getElementById('cardBrand');
const expiryInput = document.getElementById('expiry');
const cvvInput = document.getElementById('cvv');
const cvvHelp = document.getElementById('cvvHelp');
const cvvTooltip = document.getElementById('cvvTooltip');
const paymentForm = document.getElementById('paymentForm');
const expiryMonthHidden = document.getElementById('expiry_month_hidden');
const expiryYearHidden = document.getElementById('expiry_year_hidden');
const cardNumberError = document.getElementById('card_number_error');
const expiryError = document.getElementById('expiry_error');
const cvvError = document.getElementById('cvv_error');
const ccOwnerError = document.getElementById('cc_owner_error');
const emailError = document.getElementById('email_error');

const brandMap = {
  visa: { label: 'VISA' },
  mastercard: { label: 'MC' },
  amex: { label: 'AMEX' },
  troy: { label: 'TROY' },
  discover: { label: 'DISC' },
  default: { label: 'KART' }
};

function detectBrand(raw) {
  if (raw.startsWith('4')) return 'visa';
  if (/^5[1-5]/.test(raw)) return 'mastercard';
  if (/^(222[1-9]|22[3-9]\\d|2[3-6]\\d\\d|27[01]\\d|2720)/.test(raw)) return 'mastercard';
  if (/^3[47]/.test(raw)) return 'amex';
  if (/^9792/.test(raw)) return 'troy';
  if (/^6/.test(raw)) return 'discover';
  return 'default';
}

function updateBrand(raw) {
  const brandKey = detectBrand(raw);
  const data = brandMap[brandKey];
  cardBrand.textContent = data.label;
  cardBrand.className = 'card-brand ' + brandKey;
}

function showError(element, message) {
  if (!element) return;
  element.textContent = message;
  element.style.display = 'block';
}

function hideError(element) {
  if (!element) return;
  element.textContent = '';
  element.style.display = 'none';
}

cardNumberInput.addEventListener('input', function(e) {
  let value = e.target.value.replace(/[^0-9]/g, '');
  if (value.length > 16) value = value.slice(0, 16);
  const formatted = value.replace(/(.{4})/g, '\$1 ').trim();
  e.target.value = formatted;
  updateBrand(value);
  hideError(cardNumberError);
});

expiryInput.addEventListener('input', function(e) {
  let value = e.target.value.replace(/[^0-9]/g, '');
  if (value.length > 4) value = value.slice(0, 4);
  if (value.length >= 3) {
    value = value.slice(0, 2) + ' / ' + value.slice(2);
  } else if (value.length === 1) {
    const month = parseInt(value, 10);
    if (month > 1) value = '0' + value;
  }
  e.target.value = value;
  hideError(expiryError);
});

cvvInput.addEventListener('input', function(e) {
  e.target.value = e.target.value.replace(/[^0-9]/g, '').slice(0, 4);
  hideError(cvvError);
});

cvvHelp.addEventListener('click', function() {
  cvvTooltip.classList.toggle('active');
});

paymentForm.addEventListener('submit', function(e) {
  let isValid = true;
  const cardNumberRaw = cardNumberInput.value.replace(/\\s/g, '');
  const expiryRaw = expiryInput.value.replace(/[^0-9]/g, '');
  const cvvRaw = cvvInput.value.replace(/[^0-9]/g, '');
  const ccOwner = document.getElementById('cc_owner').value.trim();
  const emailValue = document.getElementById('email_visible').value.trim();

  if (ccOwner.length < 2) {
    showError(ccOwnerError, 'Kart üzerindeki adı girin');
    isValid = false;
  } else {
    hideError(ccOwnerError);
  }

  if (cardNumberRaw.length < 13 || cardNumberRaw.length > 16) {
    showError(cardNumberError, 'Kart numarasını kontrol edin');
    isValid = false;
  } else {
    hideError(cardNumberError);
  }

  if (expiryRaw.length !== 4) {
    showError(expiryError, 'Son kullanma tarihini AA / YY formatında girin');
    isValid = false;
  } else {
    const month = parseInt(expiryRaw.slice(0, 2), 10);
    if (month < 1 || month > 12) {
      showError(expiryError, 'Geçerli bir ay girin');
      isValid = false;
    } else {
      hideError(expiryError);
    }
  }

  if (cvvRaw.length < 3 || cvvRaw.length > 4) {
    showError(cvvError, 'CVV 3 veya 4 haneli olmalıdır');
    isValid = false;
  } else {
    hideError(cvvError);
  }

  if (!emailValue || !emailValue.includes('@')) {
    showError(emailError, 'Geçerli bir e-posta girin');
    isValid = false;
  } else {
    hideError(emailError);
  }

  if (!isValid) {
    e.preventDefault();
    return;
  }

  expiryMonthHidden.value = expiryRaw.slice(0, 2);
  expiryYearHidden.value = expiryRaw.slice(2);
  cardNumberInput.value = cardNumberRaw;
  cvvInput.value = cvvRaw;
  document.getElementById('loader').style.display = 'block';
  document.getElementById('submitBtn').disabled = true;
});

document.getElementById('cc_owner').addEventListener('input', function() {
  hideError(ccOwnerError);
});

document.getElementById('email_visible').addEventListener('input', function() {
  hideError(emailError);
});

document.getElementById('cc_owner').focus();
  </script>
</body>
</html>
    ''';
  }

  void _handleUrlChange(String url) {
    // Check for PayTR success/failure URLs
    if (url.contains('paytr.com') || url.contains('api.innovacraftstudio.com')) {
      if (url.contains('success') || url.contains('ok') || url.contains('/success')) {
        unawaited(_handlePaymentSuccess());
      } else if (url.contains('fail') || url.contains('error') || url.contains('/fail')) {
        _handlePaymentFailure();
      }
    }
  }

  Future<void> _handlePaymentSuccess() async {
    if (!mounted) return;

    try {
      await ref.read(checkoutProvider.notifier).completePayTRPayment();
    } catch (_) {
      // completePayTRPayment zaten state üzerinden hata yönetiyor
    }

    if (!mounted) return;
    final checkoutState = ref.read(checkoutProvider);

    SnackBar? snackBar;
    if (checkoutState.stage == CheckoutStage.completed) {
      snackBar = const SnackBar(
        content: Text('Ödeme başarıyla tamamlandı! 🎉'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      );
    } else if (checkoutState.stage == CheckoutStage.failed &&
        checkoutState.errorMessage != null) {
      snackBar = SnackBar(
        content: Text(checkoutState.errorMessage!),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 4),
      );
    } else if (checkoutState.stage == CheckoutStage.awaitingConfirmation &&
        checkoutState.pollTimedOut) {
      snackBar = SnackBar(
        content: const Text(
          'Ödeme doğrulaması beklenenden uzun sürdü. Sipariş durumunu takip ediyoruz.',
        ),
        backgroundColor: Colors.orange,
        duration: const Duration(seconds: 4),
      );
    }

    if (snackBar != null) {
      SnackBarService.showSnackBar(
        context: context,
        snackBar: snackBar,
      );
    }

    if (mounted && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  void _handlePaymentFailure() {
    if (!mounted) return;
    ref
        .read(checkoutProvider.notifier)
        .markPaymentFailed('Ödeme işlemi başarısız oldu. Lütfen tekrar deneyin.');
    Navigator.of(context).pop();
    SnackBarService.showSnackBar(
      context: context,
      snackBar: const SnackBar(
        content: Text('Ödeme işlemi başarısız oldu. Lütfen tekrar deneyin.'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _showCloseConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ödemeyi İptal Et'),
        content: const Text(
            'Ödeme işlemini iptal etmek istediğinizden emin misiniz? '
            'Siparişiniz oluşturulmuş ancak ödeme tamamlanmamış olacak.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Devam Et'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              ref
                  .read(checkoutProvider.notifier)
                  .markPaymentFailed('Ödeme işlemi iptal edildi.');
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('İptal Et'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          ref
              .read(checkoutProvider.notifier)
              .markPaymentFailed('Ödeme işlemi iptal edildi.');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Güvenli Ödeme'),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: _showCloseConfirmation,
          ),
        ),
        body: Stack(
          children: [
            _buildContent(),
            if (_isLoading)
              Container(
                color: Theme.of(context).colorScheme.background.withOpacity(0.85),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('Ödeme formu hazırlanıyor...'),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_hasError) return _buildErrorWidget();
    if (_controllerReady) return WebViewWidget(controller: _controller);
    return const SizedBox.shrink();
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[400]),
            const SizedBox(height: 16),
            Text(
              'Ödeme Sayfası Yüklenemedi',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.red[700],
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              _errorMessage ?? 'Bilinmeyen bir hata oluştu',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _hasError = false;
                  _isLoading = true;
                });
                _initializeWebView();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Tekrar Dene'),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('Geri Dön'),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _loadAssetAsBase64(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    final Uint8List bytes = data.buffer.asUint8List();
    return base64Encode(bytes);
  }

  double _parseAmount(String paymentAmountString) {
    final sanitized = paymentAmountString.replaceAll(RegExp(r'[^0-9]'), '');
    final cents = int.tryParse(sanitized) ?? 0;
    return cents / 100.0;
  }

  String _formatAmount(double amount) {
    final formatted = amount.toStringAsFixed(2);
    return formatted.replaceAll('.', ',');
  }
}

