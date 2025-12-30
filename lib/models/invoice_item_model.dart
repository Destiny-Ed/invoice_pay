import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:invoice_pay/utils/app_locales.dart';

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

  String title(BuildContext context) {
    switch (type) {
      case InvoiceActivityType.created:
        return AppLocale.invoiceCreated.getString(context);
      case InvoiceActivityType.sent:
        return AppLocale.invoiceSent.getString(context);
      case InvoiceActivityType.viewed:
        return AppLocale.invoiceViewed.getString(context);
      case InvoiceActivityType.paymentReceived:
        return AppLocale.paymentReceived.getString(context);
      case InvoiceActivityType.overdue:
        return AppLocale.invoiceOverdue.getString(context);
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
