import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:invoice_pay/providers/auth_provider.dart';
import 'package:invoice_pay/screens/invoice/invoice_template.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

import '../providers/base_provider.dart';
import '../models/invoice_model.dart';
import '../models/invoice_item_model.dart';
import '../models/client_model.dart';
import '../models/company_model.dart';

class InvoiceProvider extends BaseViewModel {
  // ==========================================================
  // INVOICES LIST
  // ==========================================================

  List<InvoiceModel> _invoices = [];
  List<InvoiceModel> get invoices => List.unmodifiable(_invoices);

  InvoiceModel? _singleInvoice;
  InvoiceModel? get singleInvoice => _singleInvoice;

  // ==========================================================
  // PAYMENT SETTINGS
  // ==========================================================

  bool _draftReceivePayment = false;
  bool get draftReceivePayment => _draftReceivePayment;

  String _draftPaymentMethod = 'bank_transfer';
  String get draftPaymentMethod => _draftPaymentMethod;

  String _draftPaymentDetails = '';
  String get draftPaymentDetails => _draftPaymentDetails;

  void toggleDraftReceivePayment(bool value) {
    _draftReceivePayment = value;
    notifyListeners();
  }

  void setDraftPaymentMethod(String method) {
    _draftPaymentMethod = method;
    notifyListeners();
  }

  void updateDraftPaymentDetails(String details) {
    _draftPaymentDetails = details;
    notifyListeners();
  }

  // ==========================================================
  // FIRESTORE CRUD
  // ==========================================================

  Future<void> loadInvoices() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      setError('User not authenticated');
      setLoading(ViewState.Error);
      return;
    }

    try {
      setLoading(ViewState.Busy);

      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('invoices')
          .orderBy('due', descending: true)
          .get();

      _invoices = snapshot.docs
          .map((d) => InvoiceModel.fromMap(d.id, d.data()))
          .toList();

      setLoading(ViewState.Success);
      notifyListeners();
    } catch (e, s) {
      setError('Failed to load invoices $e', s: s);
      setLoading(ViewState.Error);
    }
  }

  Future<void> loadSingleInvoice(String invoiceId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      setError('User not authenticated');
      setLoading(ViewState.Error);
      return;
    }

    try {
      setLoading(ViewState.Busy);

      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('invoices')
          .doc(invoiceId)
          .get();

      _singleInvoice = InvoiceModel.fromMap(snapshot.id, snapshot.data()!);

      setLoading(ViewState.Success);
      notifyListeners();
    } catch (e, s) {
      setError('Failed to load single invoice $e', s: s);
      setLoading(ViewState.Error);
    }
  }

  Future<bool> addInvoice(InvoiceModel invoice) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;

    try {
      setLoading(ViewState.Busy);

      final ref = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('invoices')
          .add(invoice.toMap());

      _invoices.insert(0, invoice.copyWith(id: ref.id));
      notifyListeners();

      setLoading(ViewState.Success);
      unawaited(loadInvoices());
      return true;
    } catch (_) {
      setError('Failed to create invoice');
      setLoading(ViewState.Error);
      return false;
    }
  }

  Future<bool> updateInvoice(InvoiceModel invoice) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;

    try {
      setLoading(ViewState.Busy);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('invoices')
          .doc(invoice.id)
          .update(invoice.toMap());

      final index = _invoices.indexWhere((i) => i.id == invoice.id);
      if (index != -1) _invoices[index] = invoice;

      await loadSingleInvoice(invoice.id);
      return true;
    } catch (e, s) {
      setError('Failed to update invoice $e', s: s);
      setLoading(ViewState.Error);
      return false;
    }
  }

  Future<bool> deleteInvoice(String id) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;

    try {
      setLoading(ViewState.Busy);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('invoices')
          .doc(id)
          .delete();

      _invoices.removeWhere((i) => i.id == id);
      notifyListeners();

      setLoading(ViewState.Success);
      return true;
    } catch (_) {
      setError('Failed to delete invoice');
      setLoading(ViewState.Error);
      return false;
    }
  }

  // ==========================================================
  // DRAFT STATE
  // ==========================================================

  String _draftInvoiceNumber = 'INV-';
  String get draftInvoiceNumber => _draftInvoiceNumber;

  DateTime _draftIssuedDate = DateTime.now();
  DateTime get draftIssuedDate => _draftIssuedDate;

  DateTime _draftDueDate = DateTime.now().add(const Duration(days: 30));
  DateTime get draftDueDate => _draftDueDate;

  ClientModel? _draftSelectedClient;
  ClientModel? get draftSelectedClient => _draftSelectedClient;

  // ---------- TEMPLATE ----------
  TemplateType _draftTemplate = TemplateType.minimal;
  TemplateType get draftTemplate => _draftTemplate;

  List<String> get templates => TemplateType.values.map((e) => e.name).toList();

  String get draftSelectedTemplate => _draftTemplate.name;

  void selectDraftTemplate(String value) {
    _draftTemplate = TemplateType.values.firstWhere((e) => e.name == value);
    notifyListeners();
  }

  // ---------- ITEMS ----------
  final List<InvoiceItemModel> _draftItems = [InvoiceItemModel()];
  List<InvoiceItemModel> get draftItems => _draftItems;

  double _draftTaxPercent = 0;
  double get draftTaxPercent => _draftTaxPercent;

  double _draftDiscountPercent = 0;
  double get draftDiscountPercent => _draftDiscountPercent;

  // ==========================================================
  // CALCULATIONS
  // ==========================================================

  double get draftSubtotal => _draftItems.fold(0, (s, i) => s + i.amount);

  double get draftTaxAmount => draftSubtotal * (_draftTaxPercent / 100);

  double get draftDiscountAmount =>
      draftSubtotal * (_draftDiscountPercent / 100);

  double get draftTotal => draftSubtotal + draftTaxAmount - draftDiscountAmount;

  bool get canCreateDraftInvoice =>
      _draftSelectedClient != null &&
      _draftItems.every(
        (i) => i.description.isNotEmpty && i.qty > 0 && i.rate > 0,
      );

  // ==========================================================
  // DRAFT MUTATORS
  // ==========================================================

  void updateDraftInvoiceNumber(String v) {
    _draftInvoiceNumber = v;
    notifyListeners();
  }

  void updateDraftIssuedDate(DateTime d) {
    _draftIssuedDate = d;
    notifyListeners();
  }

  void updateDraftDueDate(DateTime d) {
    _draftDueDate = d;
    notifyListeners();
  }

  void selectDraftClient(ClientModel c) {
    _draftSelectedClient = c;
    notifyListeners();
  }

  void addDraftItem() {
    _draftItems.add(InvoiceItemModel());
    notifyListeners();
  }

  void removeDraftItem(int i) {
    if (_draftItems.length > 1) {
      _draftItems.removeAt(i);
      notifyListeners();
    }
  }

  void updateDraftItemDescription(int i, String v) {
    _draftItems[i].description = v;
    notifyListeners();
  }

  void updateDraftItemQuantity(int i, double q) {
    if (q >= 1) {
      _draftItems[i].qty = q;
      _draftItems[i].amount = q * _draftItems[i].rate;
      notifyListeners();
    }
  }

  void incrementDraftQuantity(int i) {
    _draftItems[i].qty += 1;
    _draftItems[i].amount = _draftItems[i].qty * _draftItems[i].rate;
    notifyListeners();
  }

  void decrementDraftQuantity(int i) {
    if (_draftItems[i].qty > 1) {
      _draftItems[i].qty -= 1;
      _draftItems[i].amount = _draftItems[i].qty * _draftItems[i].rate;
      notifyListeners();
    }
  }

  void updateDraftItemRate(int i, double r) {
    _draftItems[i].rate = r;
    _draftItems[i].amount = r * _draftItems[i].qty;
    notifyListeners();
  }

  void updateDraftTaxPercent(double v) {
    _draftTaxPercent = v;
    notifyListeners();
  }

  void updateDraftDiscountPercent(double v) {
    _draftDiscountPercent = v;
    notifyListeners();
  }

  // ==========================================================
  // LIST FILTERS (USED BY UI)
  // ==========================================================

  InvoiceStatus? _listSelectedStatus;
  InvoiceStatus? get listSelectedStatus => _listSelectedStatus;

  DateTime? _listStartDate;
  DateTime? get listStartDate => _listStartDate;

  DateTime? _listEndDate;
  DateTime? get listEndDate => _listEndDate;

  String _listSearchQuery = '';
  String get listSearchQuery => _listSearchQuery;

  List<InvoiceModel> filteredInvoices(BuildContext context) {
    return _invoices.where((inv) {
      if (_listSelectedStatus != null && inv.status != _listSelectedStatus)
        return false;
      if (_listStartDate != null && inv.due.isBefore(_listStartDate!))
        return false;
      if (_listEndDate != null && inv.due.isAfter(_listEndDate!)) return false;

      if (_listSearchQuery.isNotEmpty) {
        final q = _listSearchQuery.toLowerCase();
        if (!inv.number.toLowerCase().contains(q)) return false;
      }
      return true;
    }).toList();
  }

  void setListStatusFilter(InvoiceStatus? v) {
    _listSelectedStatus = v;
    notifyListeners();
  }

  void setListStartDate(DateTime? d) {
    _listStartDate = d;
    notifyListeners();
  }

  void setListEndDate(DateTime? d) {
    _listEndDate = d;
    notifyListeners();
  }

  void setListSearchQuery(String q) {
    _listSearchQuery = q;
    notifyListeners();
  }

  void clearListFilters() {
    _listSelectedStatus = null;
    _listStartDate = null;
    _listEndDate = null;
    _listSearchQuery = '';
    notifyListeners();
  }

  // ==========================================================
  // PREVIEW INVOICE
  // ==========================================================

  InvoiceModel previewInvoice(BuildContext context) {
    return InvoiceModel(
      id: 'preview',
      number: _draftInvoiceNumber,
      clientId: _draftSelectedClient?.id ?? '',
      issued: _draftIssuedDate,
      due: _draftDueDate,
      items: List.from(_draftItems),
      taxPercent: _draftTaxPercent,
      discountPercent: _draftDiscountPercent,
      receivePayment: _draftReceivePayment,
      paymentMethod: _draftPaymentMethod,
      paymentDetails: _draftPaymentDetails,
      templateType: _draftTemplate,
    );
  }

  // ==========================================================
  // PDF
  // ==========================================================

  Future<File> generatePdf({
    required InvoiceModel invoice,
    required CompanyModel company,
    required ClientModel client,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.all(32),
        build: (_) => PdfInvoiceTemplate.build(
          invoice: invoice,
          company: company,
          client: client,
          template: invoice.templateType,
        ),
      ),
    );

    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/invoice_${invoice.number}.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  // ==========================================================
  // RESET
  // ==========================================================

  void resetDraft() {
    _draftInvoiceNumber = 'INV-${DateTime.now().millisecondsSinceEpoch}';
    _draftIssuedDate = DateTime.now();
    _draftDueDate = DateTime.now().add(const Duration(days: 30));
    _draftSelectedClient = null;
    _draftTemplate = TemplateType.minimal;
    _draftItems
      ..clear()
      ..add(InvoiceItemModel());
    _draftTaxPercent = 0;
    _draftDiscountPercent = 0;
    _draftReceivePayment = false;
    _draftPaymentMethod = 'bank_transfer';
    _draftPaymentDetails = '';
    notifyListeners();
  }
}
