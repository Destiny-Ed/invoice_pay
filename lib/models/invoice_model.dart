import 'package:invoice_pay/models/invoice_item_model.dart';

enum InvoiceStatus { draft, sent, pending, paid, overdue, partial }

enum TemplateType { minimal, bold, classic, modern, creative }

class InvoiceModel {
  final String id;
  final String number;
  final String clientId;
  final DateTime issued;
  final DateTime due;
  final List<InvoiceItemModel> items;
  final List<InvoiceActivityModel> activities;
  final double taxPercent;
  final double discountPercent;
  final double paidAmount;
  final InvoiceStatus status;
  final TemplateType templateType;
  bool receivePayment;
  String paymentMethod; // bank_transfer, paypal, stripe, upi
  String paymentDetails; // e.g. Account number, PayPal email, etc.
  final String? currencyCode;
  final String? currencySymbol;
  final bool useCompanyCurrency; // true = use company default, false = custom

  InvoiceModel({
    required this.id,
    required this.number,
    required this.clientId,
    required this.issued,
    required this.due,
    required this.items,
    this.activities = const [],
    this.taxPercent = 0.0,
    this.discountPercent = 0.0,
    this.paidAmount = 0.0,
    this.status = InvoiceStatus.draft,
    required this.templateType,
    this.receivePayment = false,
    this.paymentDetails = "bank_transfer",
    this.paymentMethod = "",
    this.currencyCode,
    this.currencySymbol,
    this.useCompanyCurrency = true,
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

    final List<dynamic> activitiesList = map['activities'] ?? [];
    final List<InvoiceActivityModel> activities = activitiesList
        .map((e) => InvoiceActivityModel.fromMap(e as Map<String, dynamic>))
        .toList();

    return InvoiceModel(
      id: id,
      number: map['number'] ?? '',
      templateType: TemplateType.values.firstWhere(
        (e) => e.name == map['template_type'],
        orElse: () => TemplateType.minimal,
      ),
      clientId: map['client_id'] ?? '',
      issued: DateTime.parse(map['issued'] ?? DateTime.now().toIso8601String()),

      due: DateTime.parse(map['due'] ?? DateTime.now().toIso8601String()),
      items: items,
      activities: activities,
      taxPercent: (map['tax_percent'] ?? 0.0).toDouble(),
      discountPercent: (map['discount_percent'] ?? 0.0).toDouble(),
      paidAmount: (map['paid_amount'] ?? 0.0).toDouble(),
      status: InvoiceStatus.values.firstWhere(
        (e) => e.index == (map['status'] ?? 0),
        orElse: () => InvoiceStatus.draft,
      ),
      receivePayment: map['receive_payment'] ?? false,
      paymentMethod: map['payment_method'] ?? 'bank_transfer',
      paymentDetails: map['payment_details'] ?? '',
      currencyCode: map['currency_code'] ?? 'USD',
      currencySymbol: map['currency_symbol'],
      useCompanyCurrency: map['use_company_currency'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'client_id': clientId,
      'issued': issued.toIso8601String(),
      'due': due.toIso8601String(),
      'items': items.map((e) => e.toMap()).toList(),
      'activities': activities.map((e) => e.toMap()).toList(),
      'tax_percent': taxPercent,
      'discount_percent': discountPercent,
      'paid_amount': paidAmount,
      'status': status.index,
      'template_type': templateType.name,
      'receive_payment': receivePayment,
      'payment_method': paymentMethod,
      'payment_details': paymentDetails,
      'currency_code': currencyCode,
      'currency_symbol': currencySymbol,
      'use_company_currency': useCompanyCurrency,
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
    List<InvoiceActivityModel>? activities,
    double? taxPercent,
    double? discountPercent,
    double? paidAmount,
    InvoiceStatus? status,
    TemplateType? templateType,
    bool? receivePayment,
    String? paymentMethod,
    String? paymentDetails,
    String? currencyCode,
    String? currencySymbol,
    bool? useCompanyCurrency,
  }) {
    return InvoiceModel(
      id: id ?? this.id,
      number: number ?? this.number,
      clientId: clientId ?? this.clientId,
      templateType: templateType ?? this.templateType,
      issued: issued ?? this.issued,
      due: due ?? this.due,
      items: items ?? this.items,
      activities: activities ?? this.activities,
      taxPercent: taxPercent ?? this.taxPercent,
      discountPercent: discountPercent ?? this.discountPercent,
      paidAmount: paidAmount ?? this.paidAmount,
      status: status ?? this.status,
      receivePayment: receivePayment ?? this.receivePayment,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentDetails: paymentDetails ?? this.paymentDetails,
      currencyCode: currencyCode ?? this.currencyCode,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      useCompanyCurrency: useCompanyCurrency ?? this.useCompanyCurrency,
    );
  }
}
