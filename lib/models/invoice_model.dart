// models/invoice_model.dart
import 'package:invoice_pay/models/invoice_item_model.dart';

enum InvoiceStatus { draft, sent, pending, paid, overdue, partial }

class InvoiceModel {
  final String id;
  final String number;
  final String clientId;
  final DateTime issued;
  final DateTime due;
  final List<InvoiceItemModel> items;
  final double taxPercent;
  final double discountPercent;
  final double paidAmount;
  final InvoiceStatus status;
  DateTime? sentDate;

  InvoiceModel({
    required this.id,
    required this.number,
    required this.clientId,
    required this.issued,
    required this.due,
    required this.items,
    this.taxPercent = 0.0,
    this.discountPercent = 0.0,
    this.paidAmount = 0.0,
    this.status = InvoiceStatus.draft,
    this.sentDate,
  });

  // Calculated getters
  double get subtotal => items.fold(0.0, (sum, item) => sum + item.amount);

  double get taxAmount => subtotal * (taxPercent / 100);

  double get discountAmount => subtotal * (discountPercent / 100);

  double get total => subtotal + taxAmount - discountAmount;

  double get balanceDue => total - paidAmount;

  bool get isOverdue =>
      status != InvoiceStatus.paid && DateTime.now().isAfter(due);

  bool get isPartiallyPaid => paidAmount > 0 && paidAmount < total;

  // Auto-determine status if needed
  InvoiceStatus get calculatedStatus {
    if (paidAmount >= total) return InvoiceStatus.paid;
    if (isPartiallyPaid) return InvoiceStatus.partial;
    if (isOverdue) return InvoiceStatus.overdue;
    if (status == InvoiceStatus.sent) return InvoiceStatus.pending;
    return status;
  }

  factory InvoiceModel.fromMap(String id, Map<String, dynamic> map) {
    final List<dynamic> itemList = map['items'] ?? [];
    final List<InvoiceItemModel> items = itemList
        .map((e) => InvoiceItemModel.fromMap(e as Map<String, dynamic>))
        .toList();

    return InvoiceModel(
      id: id,
      number: map['number'] ?? '',
      clientId: map['client_id'] ?? '',
      issued: DateTime.parse(map['issued'] ?? DateTime.now().toIso8601String()),
      sentDate: DateTime.parse(
        map['sent_date'] ?? DateTime.now().toIso8601String(),
      ),
      due: DateTime.parse(map['due'] ?? DateTime.now().toIso8601String()),
      items: items,
      taxPercent: (map['tax_percent'] ?? 0.0).toDouble(),
      discountPercent: (map['discount_percent'] ?? 0.0).toDouble(),
      paidAmount: (map['paid_amount'] ?? 0.0).toDouble(),
      status: InvoiceStatus.values.firstWhere(
        (e) => e.index == (map['status'] ?? 0),
        orElse: () => InvoiceStatus.draft,
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'client_id': clientId,
      'issued': issued.toIso8601String(),
      'sent_date': sentDate?.toIso8601String(),
      'due': due.toIso8601String(),
      'items': items.map((e) => e.toMap()).toList(),
      'tax_percent': taxPercent,
      'discount_percent': discountPercent,
      'paid_amount': paidAmount,
      'status': status.index,
    };
  }

  // For copying with modifications
  InvoiceModel copyWith({
    String? id,
    String? number,
    String? clientId,
    DateTime? issued,
    DateTime? sentDate,
    DateTime? due,
    List<InvoiceItemModel>? items,
    double? taxPercent,
    double? discountPercent,
    double? paidAmount,
    InvoiceStatus? status,
  }) {
    return InvoiceModel(
      id: id ?? this.id,
      number: number ?? this.number,
      clientId: clientId ?? this.clientId,
      issued: issued ?? this.issued,
      sentDate: sentDate ?? this.sentDate,
      due: due ?? this.due,
      items: items ?? this.items,
      taxPercent: taxPercent ?? this.taxPercent,
      discountPercent: discountPercent ?? this.discountPercent,
      paidAmount: paidAmount ?? this.paidAmount,
      status: status ?? this.status,
    );
  }
}
