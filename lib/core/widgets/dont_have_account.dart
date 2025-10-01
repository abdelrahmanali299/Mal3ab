import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DontHaveAccount extends StatelessWidget {
  const DontHaveAccount({
    super.key,
    required this.text,
    required this.subText,
    required this.onTap,
  });
  final String text;
  final String subText;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text,
            style: TextStyle(color: Colors.black),
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = onTap,
            text: subText,

            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }
}
