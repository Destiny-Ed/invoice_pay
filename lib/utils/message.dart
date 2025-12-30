import 'package:alert_info/alert_info.dart';
import 'package:flutter/material.dart';

void showMessage(BuildContext context, String message, {bool isError = false}) {
  AlertInfo.show(
    context: context,
    text: message,
    typeInfo: isError ? TypeInfo.error : TypeInfo.success,
  );
}
