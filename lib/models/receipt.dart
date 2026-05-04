class Receipt {
  final int? id;
  final String merchantName;
  final String date;
  final double totalAmount;
  final String category;

  Receipt({this.id, required this.merchantName, required this.date, required this.totalAmount, required this.category});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'merchantName': merchantName,
      'date': date,
      'totalAmount': totalAmount,
      'category': category,
    };
  }

  factory Receipt.fromMap(Map<String, dynamic> map) {
    return Receipt(
      id: map['id'],
      merchantName: map['merchantName'],
      date: map['date'],
      totalAmount: map['totalAmount'] is int ? (map['totalAmount'] as int).toDouble() : map['totalAmount'],
      category: map['category'],
    );
  }
}
