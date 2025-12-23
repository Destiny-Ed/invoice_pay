import 'package:flutter/material.dart';
import 'package:invoice_pay/styles/colors.dart';
import 'package:invoice_pay/styles/theme.dart';
 

class CustomButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final double? width;
  final Color? bgColor;
  const CustomButton({
    super.key,
    required this.onPressed,
    this.text = 'Continue',
    this.width,
    this.bgColor,
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
      child: Text(text, style: AppTheme.titleStyle(color: whiteColor)),
    );
  }
}
