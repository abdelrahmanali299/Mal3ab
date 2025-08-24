import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    this.maxlines = 1,
    this.onsaved,
    this.onChanged,
    this.controller,
  });
  final String hint;
  final int maxlines;
  final Function(String)? onChanged;
  final void Function(String?)? onsaved;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      onSaved: onsaved,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Feild is requird';
        } else {
          return null;
        }
      },
      // cursorColor: kPrimarycolor,
      maxLines: maxlines,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xffEDEDED),

        hintText: hint,
        // hintStyle: const TextStyle(color: kPrimarycolor),
        enabledBorder: borderBuilder(),
        // focusedBorder: borderBuilder(kPrimarycolor),
        border: borderBuilder(),
      ),
    );
  }

  OutlineInputBorder borderBuilder([color]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Color(0xffEDEDED)),
    );
  }
}
