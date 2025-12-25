import 'package:flutter/material.dart';
import 'package:invoice_pay/config/extension.dart';
import 'package:invoice_pay/styles/colors.dart';
import 'package:invoice_pay/styles/theme.dart';

class CustomButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final double? width;
  final Color? bgColor;
  final Color? textColor;
  final IconData? icon;
  const CustomButton({
    super.key,
    required this.onPressed,
    this.text = 'Continue',
    this.width,
    this.bgColor,
    this.textColor = whiteColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor ?? primaryColor,
        foregroundColor: textColor,
        padding: const EdgeInsets.symmetric(vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 8,
        shadowColor: Colors.black.withOpacity(0.3),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
