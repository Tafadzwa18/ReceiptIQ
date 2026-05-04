class ParsedReceipt {
  final String merchantName;
  final String date;
  final String totalAmount;
  final String tax;

  ParsedReceipt({
    required this.merchantName,
    required this.date,
    required this.totalAmount,
    required this.tax,
  });
}

class ReceiptParserService {
  static ParsedReceipt parse(String rawText) {
    // Basic heuristic-based parsing for MVP
    
    // 1. Merchant Name: usually the first non-empty line
    final lines = rawText.split('\n').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    String merchant = lines.isNotEmpty ? lines.first : 'Unknown Merchant';
    
    // 2. Date: Look for something resembling a date (MM/DD/YYYY or similar)
    // Basic regex for date
    final dateRegex = RegExp(r"(\d{1,2}[/-]\d{1,2}[/-]\d{2,4})");
    String date = '';
    for (var line in lines) {
      final match = dateRegex.firstMatch(line);
      if (match != null) {
        date = match.group(0) ?? '';
        break;
      }
    }
    if (date.isEmpty) {
      date = DateTime.now().toString().split(' ')[0]; // Fallback to today
    }

    // 3. Amount and Tax: look for keywords and numbers
    double maxAmount = 0.0;
    String taxStr = '0.00';
    
    final moneyRegex = RegExp(r"\$?(\d+\.\d{2})");
    
    for (var line in lines) {
      final lowerLine = line.toLowerCase();
      final match = moneyRegex.firstMatch(line);
      
      if (match != null) {
        final amount = double.tryParse(match.group(1) ?? '0') ?? 0.0;
        
        if (lowerLine.contains('tax')) {
          taxStr = amount.toStringAsFixed(2);
        }
        
        if (amount > maxAmount) {
          maxAmount = amount;
        }
      }
    }
    
    return ParsedReceipt(
      merchantName: merchant,
      date: date,
      totalAmount: maxAmount > 0 ? maxAmount.toStringAsFixed(2) : '',
      tax: taxStr,
    );
  }
}
