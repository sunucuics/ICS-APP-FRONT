import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../core/services/snackbar_service.dart';

class PayTRWebViewPage extends StatefulWidget {
  final String orderId;
  final String iframeUrl;

  const PayTRWebViewPage({
    super.key,
    required this.orderId,
    required this.iframeUrl,
  });

  @override
  State<PayTRWebViewPage> createState() => _PayTRWebViewPageState();
}

class _PayTRWebViewPageState extends State<PayTRWebViewPage> {
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
            // Update loading progress
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
      ..loadRequest(Uri.parse(widget.iframeUrl));
  }

  void _handleUrlChange(String url) {
    // Check for PayTR success/failure URLs
    if (url.contains('paytr.com')) {
      if (url.contains('success') || url.contains('ok')) {
        _handlePaymentSuccess();
      } else if (url.contains('fail') || url.contains('error')) {
        _handlePaymentFailure();
      }
    }
  }

  void _handlePaymentSuccess() {
    // Payment successful - navigate back to orders
    if (mounted) {
      Navigator.of(context).popUntil((route) => route.isFirst);
      SnackBarService.showSnackBar(context: context, snackBar: 
        const SnackBar(
          content: Text('Ödeme başarıyla tamamlandı!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _handlePaymentFailure() {
    // Payment failed - show error and go back
    if (mounted) {
      Navigator.of(context).pop();
      SnackBarService.showSnackBar(context: context, snackBar: 
        const SnackBar(
          content: Text('Ödeme işlemi başarısız oldu. Lütfen tekrar deneyin.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ödeme'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            // Show confirmation dialog before closing
            _showCloseConfirmation();
          },
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
                    Text('Ödeme sayfası yükleniyor...'),
                  ],
                ),
              ),
            ),
        ],
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
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red[400],
            ),
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
                _controller.loadRequest(Uri.parse(widget.iframeUrl));
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

  void _showCloseConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ödemeyi İptal Et'),
        content: const Text(
          'Ödeme işlemini iptal etmek istediğinizden emin misiniz? '
          'Siparişiniz oluşturulmuş ancak ödeme tamamlanmamış olacak.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Devam Et'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Close WebView
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
}
