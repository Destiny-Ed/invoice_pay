import 'package:invoice_pay/models/invoice_model.dart';

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

// models/invoice_activity_model.dart
enum InvoiceActivityType { created, sent, viewed, paymentReceived, overdue }

class InvoiceActivityModel {
  final InvoiceActivityType type;
  final DateTime timestamp;
  final double? amount; // For payments

  InvoiceActivityModel({
    required this.type,
    required this.timestamp,
    this.amount,
  });

  String get title {
    switch (type) {
      case InvoiceActivityType.created:
        return 'Invoice Created';
      case InvoiceActivityType.sent:
        return 'Invoice Sent';
      case InvoiceActivityType.viewed:
        return 'Invoice Viewed';
      case InvoiceActivityType.paymentReceived:
        return 'Payment Received';
      case InvoiceActivityType.overdue:
        return 'Invoice Overdue';
    }
  }

  factory InvoiceActivityModel.fromMap(Map<String, dynamic> map) {
    return InvoiceActivityModel(
      type: InvoiceActivityType.values.firstWhere(
        (e) => e.name == map['type'],
        orElse: () => InvoiceActivityType.created,
      ),
      timestamp: DateTime.parse(map['timestamp']),
      amount: map['amount']?.toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type.name,
      'timestamp': timestamp.toIso8601String(),
      if (amount != null) 'amount': amount,
    };
  }
}
