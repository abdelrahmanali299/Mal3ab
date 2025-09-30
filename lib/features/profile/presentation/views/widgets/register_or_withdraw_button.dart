import 'package:flutter/material.dart';

class RegisterOrWithdrawButton extends StatelessWidget {
  const RegisterOrWithdrawButton({
    super.key,
    required this.size,
    required this.title,
    required this.icon,
  });

  final Size size;
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: .05),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon),
        ),
        SizedBox(width: size.width * .05),
        Text(title, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
