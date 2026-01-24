import 'dart:convert';

class PayTRHtmlBuilder {
  static final _converter = HtmlEscape(HtmlEscapeMode.attribute);

  static String buildPaymentForm({
    required String actionUrl,
    required Map<String, String> fields,
    required String cardOwner,
    required String cardNumber,
    required String expiryMonth,
    required String expiryYear,
    required String cvv,
  }) {
    final hiddenInputs = fields.entries.map((e) {
      return '<input type="hidden" name="${_escape(e.key)}" value="${_escape(e.value)}">';
    }).join('\n    ');

    return '''
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
  <form id="paytr_form" method="POST" action="$actionUrl" style="display:none;">
    $hiddenInputs
    <input type="hidden" name="cc_owner" value="${_escape(cardOwner)}">
    <input type="hidden" name="card_number" value="${_escape(cardNumber)}">
    <input type="hidden" name="expiry_month" value="${_escape(expiryMonth)}">
    <input type="hidden" name="expiry_year" value="${_escape(expiryYear)}">
    <input type="hidden" name="cvv" value="${_escape(cvv)}">
  </form>
  <script>
    document.getElementById('paytr_form').submit();
  </script>
</body>
</html>
''';
  }

  static String _escape(String text) {
    return _converter.convert(text);
  }
}
