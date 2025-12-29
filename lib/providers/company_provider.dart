import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invoice_pay/providers/auth_provider.dart';
import 'package:invoice_pay/services/upload_doc_utils.dart';
import 'dart:io';

import '../models/company_model.dart';

class CompanyProvider extends ChangeNotifier {
  String _companyDocId = 'details'; // Fixed ID
  //
  CompanyModel? _company;
  CompanyModel? get company => _company;

  ViewState _viewState = ViewState.Idle;
  ViewState get viewState => _viewState;

  String _message = "";
  String get message => _message;

  // Temporary fields used during onboarding/setup
  String companyName = '';
  String email = '';
  String phone = '';
  String street = '';
  String city = '';
  String zip = '';
  String? logoUrl;
  String selectedCurrencyCode = 'USD';
  String selectedCurrencySymbol = '\$';
  Color primaryColor = const Color(0xFF10B981); // Default green
  String fontFamily = 'Manrope';

  // Load company data from Firestore on app start
  Future<void> loadCompany() async {
    _viewState = ViewState.Busy;
    notifyListeners();

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      _viewState = ViewState.Error;
      notifyListeners();
      return;
    }

    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('company')
          .doc(_companyDocId)
          .get();

      if (doc.exists) {
        final data = doc.data();
        _company = CompanyModel.fromMap(doc.id, data!);

        // Populate temporary fields for editing
        companyName = _company!.name;
        email = _company!.email;
        phone = _company!.phone;
        street = _company!.street;
        city = _company!.city;
        zip = _company!.zip;
        logoUrl = _company!.logoUrl;
        primaryColor = _company!.primaryColor;
        fontFamily = _company!.fontFamily;
      } else {
        // First-time user — use defaults
        _company = null;
      }
      _viewState = ViewState.Success;
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading company: $e');
      _viewState = ViewState.Error;
      notifyListeners();
    }
  }

  Future<void> updateCurrency(String code, String symbol) async {
    final updated = company!.copyWith(
      currencyCode: code,
      currencySymbol: symbol,
    );
    await saveCompanyDetails(model: updated);
  }

  // Save all company details
  Future<void> saveCompanyDetails({CompanyModel? model}) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      _message = 'User not authenticated';
      _viewState = ViewState.Error;
      notifyListeners();
      return;
    }

    _viewState = ViewState.Busy;
    notifyListeners();

    try {
      final CompanyModel companyToSave;

      if (model != null) {
        companyToSave = model;
      } else {
        companyToSave = CompanyModel(
          id: _companyDocId,
          name: companyName.trim(),
          email: email.trim(),
          phone: phone.trim(),
          street: street.trim(),
          city: city.trim(),
          zip: zip.trim(),
          logoUrl: logoUrl,
          primaryColor: primaryColor,
          fontFamily: fontFamily,
          currencyCode: selectedCurrencyCode,
          currencySymbol: selectedCurrencySymbol,
        );
      }

      // Use .set() with merge: true to update/override the same document
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('company')
          .doc(_companyDocId)
          .set(companyToSave.toMap(), SetOptions(merge: true));

      _company = companyToSave;
      _viewState = ViewState.Success;
      _message = 'Company details saved successfully!';
      notifyListeners();

      // Optional: reload to confirm
      unawaited(loadCompany());
    } catch (e) {
      debugPrint('Error saving company: $e');
      _message = 'Failed to save company details';
      _viewState = ViewState.Error;
      notifyListeners();
    }
  }

  Future<void> updateMonthlyGoal(double goal) async {
    if (company == null) return;

    final updated = company!.copyWith(monthlyGoal: goal);
    await saveCompanyDetails(model: updated); // Your existing save method
  }

  // Upload logo to Firebase Storage and return URL
  Future<void> uploadLogo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
      maxWidth: 800,
    );

    if (pickedFile == null) return;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      final file = File(pickedFile.path);

      _viewState = ViewState.Busy;
      notifyListeners();

      final uploadDoc = await uploadDocumentToServer(file.path);

      _viewState = uploadDoc.state;

      if (uploadDoc.state == ViewState.Success) {
        logoUrl = uploadDoc.fileUrl;
      }

      notifyListeners();
    } catch (e, s) {
      log('Error uploading logo: $e', stackTrace: s);
    }
  }

  // Helper methods for onboarding screens
  void updatePrimaryColor(Color color) {
    primaryColor = color;
    notifyListeners();
  }

  void updateFontFamily(String font) {
    fontFamily = font;
    notifyListeners();
  }

  // Check if onboarding is complete
  bool get isOnboardingComplete => _company != null;
}
