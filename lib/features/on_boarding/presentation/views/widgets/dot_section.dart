import 'package:flutter/material.dart';
import 'package:mal3ab/features/on_boarding/presentation/views/widgets/dot.dart';

class DotSection extends StatelessWidget {
  const DotSection({super.key, required this.pageIndex});
  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 5,
      children: List.generate(2, (index) {
        return Dot(isSelected: pageIndex == index);
      }),
    );
  }
}
