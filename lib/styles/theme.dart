import 'package:flutter/material.dart';
import 'package:invoice_pay/styles/font_size.dart';

class AppTheme {
  AppTheme._();

  static TextStyle titleStyle({Color? color, bool isBold = false}) =>
      TextStyle(fontSize: titleSize, color: color, fontWeight: isBold ? FontWeight.bold : FontWeight.normal);

  static TextStyle subTitleStyle({Color? color, bool isBold = false}) => TextStyle(
      fontSize: subTitleSize, color: color, fontWeight: isBold ? FontWeight.bold : FontWeight.normal);

  static TextStyle headerStyle({Color? color}) =>
      TextStyle(fontSize: headerSize, color: color, fontWeight: FontWeight.bold);
}
