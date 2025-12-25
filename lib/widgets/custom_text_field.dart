import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController _controller;
  bool obscure;
  final Color? backgroundColor;
  final Color? pwdVisibilityColor;
  final String hint;
  final bool password;
  final Widget? prefixIcon;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;
  final bool readOnly;
  final TextInputType? keyboardType;
  final Function(String)? onPress;
  final Function()? onTap;
  final Function()? onEditingComplete;
  final Function(String)? onFieldSubmitted;
  final String Function(String?)? validator;

  CustomTextField(
    this._controller, {
    Key? key,
    this.password = true,
    this.obscure = false,
    this.hint = '',
    this.border,
    this.pwdVisibilityColor,
    this.borderRadius,
    this.readOnly = false,
    this.backgroundColor,
    this.onPress,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onTap,
    this.keyboardType,
    this.prefixIcon,
    this.validator,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  Icon? visibility;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.key,
      controller: widget._controller,
      obscureText: widget.obscure,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        filled: true,
        hintText: widget.hint,
        fillColor: Colors.grey[100],
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.password == true
            ? GestureDetector(
                key: widget.key,
                onTap: () {
                  //Show and hide password
                  if (widget.obscure == true) {
                    setState(() {
                      widget.obscure = false;
                      visibility = Icon(
                        Icons.visibility_off,
                        color: widget.pwdVisibilityColor ?? Colors.black,
                      );
                    });
                  } else {
                    setState(() {
                      widget.obscure = true;
                      visibility = Icon(
                        Icons.visibility,
                        color: widget.pwdVisibilityColor ?? Colors.black,
                      );
                    });
                  }
                },
                child:
                    visibility ??
                    Icon(
                      Icons.visibility,
                      color: widget.pwdVisibilityColor ?? Colors.black,
                    ),
              )
            : const Text(""),
      ),
      readOnly: widget.readOnly,
      onChanged: widget.onPress,
      onTap: widget.onTap,
      keyboardType: widget.keyboardType,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onFieldSubmitted,
      validator: widget.validator,
    );
  }
}
