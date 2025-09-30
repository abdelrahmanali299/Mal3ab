import 'package:flutter/material.dart';

class AlertDialogMessage extends StatelessWidget {
  const AlertDialogMessage({
    super.key,
    required this.onConfirm,
    required this.title,
    required this.content,
  });
  final VoidCallback onConfirm;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          child: Text("Confirm", style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
