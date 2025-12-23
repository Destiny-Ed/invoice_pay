import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:invoice_pay/config/extension.dart';
import 'package:invoice_pay/providers/auth_provider.dart';
import 'package:invoice_pay/providers/base_provider.dart';
import '../models/invoice_model.dart';
import '../models/invoice_item_model.dart';
import '../models/client_model.dart';

class InvoiceProvider extends BaseViewModel {
  List<InvoiceModel> _invoices = [];
  List<InvoiceModel> get invoices => List.unmodifiable(_invoices);

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
          .map((doc) => InvoiceModel.fromMap(doc.id, doc.data()))
          .toList();

      setLoading(ViewState.Success);
      notifyListeners();
    } catch (e) {
      setError('Failed to load invoices');
      setLoading(ViewState.Error);
    }
  }

  Future<bool> addInvoice(InvoiceModel invoice) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;

    setLoading(ViewState.Busy);
    clearError();

    try {
      final ref = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('invoices')
          .add(invoice.toMap());

      final newInvoice = invoice.copyWith(id: ref.id);
      _invoices.insert(0, newInvoice);
      notifyListeners();

      setLoading(ViewState.Success);
      unawaited(loadInvoices());
      return true;
    } catch (e) {
      setError('Failed to create invoice');
      setLoading(ViewState.Error);
      return false;
    }
  }

  Future<bool> updateInvoice(InvoiceModel updatedInvoice) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      setError('User not authenticated');
      return false;
    }

    setLoading(ViewState.Busy);
    clearError();

    try {
      // Update in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('invoices')
          .doc(updatedInvoice.id)
          .update(updatedInvoice.toMap());

      // Update local list
      final index = _invoices.indexWhere((inv) => inv.id == updatedInvoice.id);
      if (index != -1) {
        _invoices[index] = updatedInvoice;
        notifyListeners();
      }

      setLoading(ViewState.Success);
      return true;
    } catch (e) {
      setError('Failed to update invoice: ${e.toString()}');
      setLoading(ViewState.Error);
      return false;
    }
  }

  Future<bool> deleteInvoice(String invoiceId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      setError('User not authenticated');
      return false;
    }

    setLoading(ViewState.Busy);
    clearError();

    try {
      // Delete from Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('invoices')
          .doc(invoiceId)
          .delete();

      // Remove from local list
      _invoices.removeWhere((inv) => inv.id == invoiceId);
      notifyListeners();

      setLoading(ViewState.Success);
      return true;
    } catch (e) {
      setError('Failed to delete invoice: ${e.toString()}');
      setLoading(ViewState.Error);
      return false;
    }
  }

  // === Create Invoice State & Logic ===
  String _draftInvoiceNumber = 'INV-';
  String get draftInvoiceNumber => _draftInvoiceNumber;

  DateTime _draftIssuedDate = DateTime.now();
  DateTime get draftIssuedDate => _draftIssuedDate;

  DateTime _draftDueDate = DateTime.now().add(const Duration(days: 30));
  DateTime get draftDueDate => _draftDueDate;

  ClientModel? _draftSelectedClient;
  ClientModel? get draftSelectedClient => _draftSelectedClient;

  String _draftSelectedTemplate = 'Minimal';
  String get draftSelectedTemplate => _draftSelectedTemplate;

  final List<InvoiceItemModel> _draftItems = [InvoiceItemModel()];
  List<InvoiceItemModel> get draftItems => _draftItems;

  double _draftTaxPercent = 0.0;
  double get draftTaxPercent => _draftTaxPercent;

  double _draftDiscountPercent = 0.0;
  double get draftDiscountPercent => _draftDiscountPercent;

  final List<String> templates = ['Minimal', 'Bold', 'Classic'];

  // Calculated Getters
  double get draftSubtotal =>
      _draftItems.fold(0.0, (sum, item) => sum + item.amount);
  double get draftTaxAmount => draftSubtotal * (_draftTaxPercent / 100);
  double get draftDiscountAmount =>
      draftSubtotal * (_draftDiscountPercent / 100);
  double get draftTotal => draftSubtotal + draftTaxAmount - draftDiscountAmount;

  bool get canCreateDraftInvoice {
    if (_draftSelectedClient == null) return false;
    return _draftItems.every(
      (item) =>
          item.description.trim().isNotEmpty && item.qty > 0 && item.rate > 0,
    );
  }

  // Setters
  void updateDraftInvoiceNumber(String value) {
    _draftInvoiceNumber = value;
    notifyListeners();
  }

  void updateDraftIssuedDate(DateTime date) {
    _draftIssuedDate = date;
    notifyListeners();
  }

  void updateDraftDueDate(DateTime date) {
    _draftDueDate = date;
    notifyListeners();
  }

  void selectDraftClient(ClientModel client) {
    _draftSelectedClient = client;
    notifyListeners();
  }

  void selectDraftTemplate(String template) {
    _draftSelectedTemplate = template;
    notifyListeners();
  }

  void addDraftItem() {
    _draftItems.add(InvoiceItemModel());
    notifyListeners();
  }

  void removeDraftItem(int index) {
    if (_draftItems.length > 1) {
      _draftItems.removeAt(index);
      notifyListeners();
    }
  }

  void updateDraftItemDescription(int index, String description) {
    _draftItems[index].description = description;
    notifyListeners();
  }

  void updateDraftItemQuantity(int index, double qty) {
    if (qty >= 1) {
      _draftItems[index].qty = qty;
      _draftItems[index].amount =
          _draftItems[index].qty * _draftItems[index].rate;
      notifyListeners();
    }
  }

  void incrementDraftQuantity(int index) {
    _draftItems[index].qty += 1;
    _draftItems[index].amount =
        _draftItems[index].qty * _draftItems[index].rate;
    notifyListeners();
  }

  void decrementDraftQuantity(int index) {
    if (_draftItems[index].qty > 1) {
      _draftItems[index].qty -= 1;
      _draftItems[index].amount =
          _draftItems[index].qty * _draftItems[index].rate;
      notifyListeners();
    }
  }

  void updateDraftItemRate(int index, double rate) {
    _draftItems[index].rate = rate;
    _draftItems[index].amount =
        _draftItems[index].qty * _draftItems[index].rate;
    notifyListeners();
  }

  void updateDraftTaxPercent(double value) {
    _draftTaxPercent = value;
    notifyListeners();
  }

  void updateDraftDiscountPercent(double value) {
    _draftDiscountPercent = value;
    notifyListeners();
  }

  // Invoices List Filters
  InvoiceStatus? _listSelectedStatus;
  InvoiceStatus? get listSelectedStatus => _listSelectedStatus;

  DateTime? _listStartDate;
  DateTime? get listStartDate => _listStartDate;

  DateTime? _listEndDate;
  DateTime? get listEndDate => _listEndDate;

  String _listSearchQuery = '';
  String get listSearchQuery => _listSearchQuery;

  // Filtered Invoices
  List<InvoiceModel> filteredInvoices(BuildContext context) {
    return _invoices.where((inv) {
      if (_listSelectedStatus != null && inv.status != _listSelectedStatus) {
        return false;
      }
      if (_listStartDate != null && inv.due.isBefore(_listStartDate!)) {
        return false;
      }
      if (_listEndDate != null && inv.due.isAfter(_listEndDate!)) return false;
      if (_listSearchQuery.isNotEmpty) {
        final query = _listSearchQuery.toLowerCase();
        final clientName = inv.getClientName(context);
        if (!inv.number.toLowerCase().contains(query) &&
            !clientName.toLowerCase().contains(query)) {
          return false;
        }
      }
      return true;
    }).toList();
  }

  // Setters
  void setListStatusFilter(InvoiceStatus? status) {
    _listSelectedStatus = status;
    notifyListeners();
  }

  void setListStartDate(DateTime? date) {
    _listStartDate = date;
    notifyListeners();
  }

  void setListEndDate(DateTime? date) {
    _listEndDate = date;
    notifyListeners();
  }

  void setListSearchQuery(String query) {
    _listSearchQuery = query;
    notifyListeners();
  }

  void clearListFilters() {
    _listSelectedStatus = null;
    _listStartDate = null;
    _listEndDate = null;
    _listSearchQuery = '';
    notifyListeners();
  }

  // Reset draft for new invoice
  void resetDraft() {
    _draftInvoiceNumber =
        'INV-${DateTime.now().year}${DateTime.now().month.toString().padLeft(2, '0')}001';
    _draftIssuedDate = DateTime.now();
    _draftDueDate = DateTime.now().add(const Duration(days: 30));
    _draftSelectedClient = null;
    _draftSelectedTemplate = 'Minimal';
    _draftItems.clear();
    _draftItems.add(InvoiceItemModel());
    _draftTaxPercent = 0.0;
    _draftDiscountPercent = 0.0;
    notifyListeners();
  }
}
