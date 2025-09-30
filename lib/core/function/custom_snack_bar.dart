import 'package:flutter/material.dart';

customSnackBar(BuildContext context, String message, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: color,
      duration: Duration(milliseconds: 500),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
