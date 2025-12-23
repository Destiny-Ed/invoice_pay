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
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.resolveWith(
          (states) => Size(width ?? MediaQuery.of(context).size.width, 0),
        ),
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) => bgColor ?? primaryColor,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) Icon(icon, color: textColor),
          if (icon != null) 5.width(),
          Text(text, style: AppTheme.titleStyle(color: textColor)),
        ],
      ),
    );
  }
}
