import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:invoice_pay/providers/auth_provider.dart';

class BaseViewModel extends ChangeNotifier {
  ViewState _viewState = ViewState.Idle;
  ViewState get viewState => _viewState;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  void setLoading(ViewState state) {
    _viewState = state;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void setError(String message, {StackTrace? s}) {
    _errorMessage = message;
    log(message, stackTrace: s);
    notifyListeners();
  }

  void clearError() {
    _errorMessage = '';
    notifyListeners();
  }
}
