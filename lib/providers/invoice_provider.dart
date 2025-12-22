import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/invoice_model.dart';

class InvoiceProvider extends ChangeNotifier {
  List<InvoiceModel> _invoices = [];
  List<InvoiceModel> get invoices => _invoices;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadInvoices() async {
    _isLoading = true;
    notifyListeners();

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      _isLoading = false;
      notifyListeners();
      return;
    }

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('invoices')
        .orderBy('due', descending: true)
        .get();

    _invoices = snapshot.docs.map((doc) => InvoiceModel.fromMap(doc.id, doc.data())).toList();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addInvoice(InvoiceModel invoice) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final ref = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('invoices')
        .add(invoice.toMap());

    final newInvoice = invoice.copyWith(id: ref.id);
    _invoices.insert(0, newInvoice); // Add to top of list
    notifyListeners();
  }

  Future<void> updateInvoice(InvoiceModel invoice) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('invoices')
        .doc(invoice.id)
        .update(invoice.toMap());

    final index = _invoices.indexWhere((i) => i.id == invoice.id);
    if (index != -1) {
      _invoices[index] = invoice;
      notifyListeners();
    }
  }

  Future<void> deleteInvoice(String id) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('invoices')
        .doc(id)
        .delete();

    _invoices.removeWhere((i) => i.id == id);
    notifyListeners();
  }
}