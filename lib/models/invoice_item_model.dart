class InvoiceItemModel {
  String description;
  double qty;
  double rate;
  double amount;

  InvoiceItemModel({
    this.description = '',
    this.qty = 1.0,
    this.rate = 0.0,
    this.amount = 0.0,
  });

  factory InvoiceItemModel.fromMap(Map<String, dynamic> map) {
    return InvoiceItemModel(
      description: map['description'] ?? '',
      qty: (map['qty'] ?? 1.0).toDouble(),
      rate: (map['rate'] ?? 0.0).toDouble(),
      amount: (map['amount'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'qty': qty,
      'rate': rate,
      'amount': amount,
    };
  }
}
