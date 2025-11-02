import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../core/models/paytr_model.dart';
import '../../../orders/providers/orders_provider.dart';

/// PayTR Direct API form submission page
/// Creates local HTML form with PayTR fields and submits to PayTR
class PayTRDirectFormPage extends ConsumerStatefulWidget {
  final String orderId;
  final PayTRDirectInitResponse initResponse;

  const PayTRDirectFormPage({
    super.key,
    required this.orderId,
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

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    _controller = WebViewController()
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
      )
      ..loadRequest(Uri.dataFromString(
        _buildHTMLForm(),
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8'),
      ));
  }

  String _buildHTMLForm() {
    final fields = widget.initResponse.fields;
    final action = widget.initResponse.action;

    // Build HTML form with PayTR fields
    return '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Güvenli Ödeme - PayTR</title>
  <style>
    body {
      margin: 0;
      padding: 20px;
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      min-height: 100vh;
    }
    .container {
      background: white;
      border-radius: 16px;
      padding: 30px;
      box-shadow: 0 20px 60px rgba(0,0,0,0.3);
      max-width: 500px;
      width: 100%;
    }
    .logo {
      text-align: center;
      margin-bottom: 20px;
    }
    .logo svg {
      width: 80px;
      height: 80px;
    }
    .title {
      text-align: center;
      color: #333;
      font-size: 24px;
      font-weight: bold;
      margin-bottom: 10px;
    }
    .subtitle {
      text-align: center;
      color: #666;
      font-size: 14px;
      margin-bottom: 30px;
    }
    .form-group {
      margin-bottom: 20px;
    }
    .form-group label {
      display: block;
      margin-bottom: 8px;
      color: #333;
      font-weight: 600;
      font-size: 14px;
    }
    .form-group input {
      width: 100%;
      padding: 12px;
      border: 2px solid #e0e0e0;
      border-radius: 8px;
      font-size: 16px;
      transition: border-color 0.3s;
      box-sizing: border-box;
    }
    .form-group input:focus {
      outline: none;
      border-color: #667eea;
    }
    .form-group.small {
      display: inline-block;
      width: calc(50% - 5px);
    }
    .form-group.small:first-child {
      margin-right: 10px;
    }
    .row {
      display: flex;
      gap: 10px;
    }
    .row .form-group {
      flex: 1;
    }
    #submitBtn {
      width: 100%;
      padding: 16px;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
      border: none;
      border-radius: 8px;
      font-size: 18px;
      font-weight: bold;
      cursor: pointer;
      transition: transform 0.2s, box-shadow 0.2s;
      box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
    }
    #submitBtn:hover {
      transform: translateY(-2px);
      box-shadow: 0 6px 20px rgba(102, 126, 234, 0.6);
    }
    #submitBtn:active {
      transform: translateY(0);
    }
    .error {
      color: #e74c3c;
      font-size: 12px;
      margin-top: 5px;
      display: none;
    }
    .loader {
      display: none;
      text-align: center;
      margin-top: 20px;
    }
    .spinner {
      border: 4px solid #f3f3f3;
      border-top: 4px solid #667eea;
      border-radius: 50%;
      width: 40px;
      height: 40px;
      animation: spin 1s linear infinite;
      margin: 0 auto;
    }
    @keyframes spin {
      0% { transform: rotate(0deg); }
      100% { transform: rotate(360deg); }
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="logo">
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="#667eea">
        <path d="M12 2L2 7l10 5 10-5-10-5z"/>
        <path d="M2 17l10 5 10-5M2 12l10 5 10-5"/>
      </svg>
    </div>
    <h1 class="title">Güvenli Ödeme</h1>
    <p class="subtitle">Kart bilgilerinizi girin ve ödemeyi tamamlayın</p>
    
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
      
      <!-- Card Input Fields -->
      <div class="form-group">
        <label for="cc_owner">Kart Üzerindeki İsim *</label>
        <input type="text" id="cc_owner" name="cc_owner" placeholder="ADI SOYADI" required>
        <div class="error" id="cc_owner_error"></div>
      </div>
      
      <div class="form-group">
        <label for="card_number">Kart Numarası *</label>
        <input type="text" id="card_number" name="card_number" placeholder="1234 5678 9012 3456" maxlength="16" required>
        <div class="error" id="card_number_error"></div>
      </div>
      
      <div class="row">
        <div class="form-group">
          <label for="expiry_month">Ay (MM) *</label>
          <input type="text" id="expiry_month" name="expiry_month" placeholder="12" maxlength="2" required>
          <div class="error" id="expiry_month_error"></div>
        </div>
        
        <div class="form-group">
          <label for="expiry_year">Yıl (YY) *</label>
          <input type="text" id="expiry_year" name="expiry_year" placeholder="30" maxlength="2" required>
          <div class="error" id="expiry_year_error"></div>
        </div>
      </div>
      
      <div class="form-group">
        <label for="cvv">CVV *</label>
        <input type="text" id="cvv" name="cvv" placeholder="123" maxlength="4" required>
        <div class="error" id="cvv_error"></div>
      </div>
      
      <div class="form-group">
        <label for="email_visible">E-posta *</label>
        <input type="email" id="email_visible" name="email" value="${fields.email}" required>
        <div class="error" id="email_error"></div>
      </div>
      
      <button type="submit" id="submitBtn">
        Ödemeyi Tamamla
      </button>
      
      <div class="loader" id="loader">
        <div class="spinner"></div>
        <p>İşleminiz gerçekleştiriliyor...</p>
      </div>
    </form>
  </div>
  
  <script>
    // Card number formatting
    document.getElementById('card_number').addEventListener('input', function(e) {
      let value = e.target.value.replace(/\\s/g, '');
      let formattedValue = value.match(/.{1,4}/g)?.join(' ') || value;
      e.target.value = formattedValue;
    });
    
    // Expiry month validation
    document.getElementById('expiry_month').addEventListener('input', function(e) {
      let value = e.target.value.replace(/[^0-9]/g, '');
      if (value && parseInt(value) > 12) {
        value = '12';
      }
      if (value && parseInt(value) < 1) {
        value = '01';
      }
      e.target.value = value;
    });
    
    // Expiry year validation
    document.getElementById('expiry_year').addEventListener('input', function(e) {
      e.target.value = e.target.value.replace(/[^0-9]/g, '');
    });
    
    // CVV validation
    document.getElementById('cvv').addEventListener('input', function(e) {
      e.target.value = e.target.value.replace(/[^0-9]/g, '');
    });
    
    // Form submission
    document.getElementById('paymentForm').addEventListener('submit', function(e) {
      // Validate form
      let isValid = true;
      
      // Remove card number spaces for submission
      let cardNumber = document.getElementById('card_number').value;
      document.getElementById('card_number').value = cardNumber.replace(/\\s/g, '');
      
      // Show loader
      document.getElementById('loader').style.display = 'block';
      document.getElementById('submitBtn').disabled = true;
      
      // If validation fails, show error and stop submission
      if (!isValid) {
        e.preventDefault();
        document.getElementById('loader').style.display = 'none';
        document.getElementById('submitBtn').disabled = false;
      }
    });
    
    // Focus first input
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
        _handlePaymentSuccess();
      } else if (url.contains('fail') || url.contains('error') || url.contains('/fail')) {
        _handlePaymentFailure();
      }
    }
  }

  void _handlePaymentSuccess() {
    // Payment successful - refresh order and navigate back
    if (mounted) {
      // Refresh order details
      ref.read(orderDetailProvider.notifier).loadOrderDetail(widget.orderId);
      
      // Navigate back to home
      Navigator.of(context).popUntil((route) => route.isFirst);
      
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ödeme başarıyla tamamlandı! 🎉'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  void _handlePaymentFailure() {
    // Payment failed - show error and go back
    if (mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Ödeme işlemi başarısız oldu. Lütfen tekrar deneyin.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
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
              Navigator.of(context).pop(); // Close form page
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
          // Refresh order details when leaving payment page
          await ref
              .read(orderDetailProvider.notifier)
              .loadOrderDetail(widget.orderId);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Güvenli Ödeme'),
          backgroundColor: Colors.purple.shade600,
          foregroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: _showCloseConfirmation,
          ),
        ),
        body: Stack(
          children: [
            if (_hasError)
              _buildErrorWidget()
            else
              WebViewWidget(controller: _controller),
            if (_isLoading)
              Container(
                color: Colors.white,
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
                _controller.loadRequest(Uri.dataFromString(
                  _buildHTMLForm(),
                  mimeType: 'text/html',
                  encoding: Encoding.getByName('utf-8'),
                ));
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
}

