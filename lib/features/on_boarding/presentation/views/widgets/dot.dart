import 'package:flutter/material.dart';

class Dot extends StatelessWidget {
  const Dot({super.key, this.isSelected = false});
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: isSelected ? 20 : 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        color: isSelected ? Colors.blue : Colors.grey,
      ),
      duration: Duration(milliseconds: 300),
    );
  }
}
