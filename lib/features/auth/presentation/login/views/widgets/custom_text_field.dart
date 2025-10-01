import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    this.maxlines = 1,
    this.onsaved,
    this.onChanged,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
    this.fillColor,
    this.focusBorderColor,
    this.readOnly = false,
    // this.labelText = '',
    this.borderColor = Colors.white,
    this.labelStyle,
    this.floatingLabelBehavior,
  });
  final String hint;
  final int maxlines;
  final Function(String)? onChanged;
  final void Function(String?)? onsaved;
  final TextEditingController? controller;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final bool isPassword;
  final Color? fillColor;
  final Color? focusBorderColor;
  final bool readOnly;
  // final String labelText;
  final Color borderColor;
  final TextStyle? labelStyle;
  final FloatingLabelBehavior? floatingLabelBehavior;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.readOnly,
      controller: widget.controller,
      onChanged: widget.onChanged,
      onSaved: widget.onsaved,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Feild is requird';
        } else {
          return null;
        }
      },
      maxLines: widget.maxlines,
      obscureText: !isPasswordVisible && widget.isPassword,
      decoration: InputDecoration(
        floatingLabelBehavior: widget.floatingLabelBehavior,
        labelStyle: widget.labelStyle,
        // labelText: widget.labelText,
        filled: true,
        fillColor: widget.fillColor ?? Colors.grey.withValues(alpha: .05),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
                icon: Icon(
                  isPasswordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
              )
            : null,
        hintText: widget.hint,
        enabledBorder: borderBuilder(),
        border: borderBuilder(),
        focusedBorder: borderBuilder(widget.focusBorderColor),
      ),
    );
  }

  OutlineInputBorder borderBuilder([color]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: widget.borderColor),
    );
  }
}
