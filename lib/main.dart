import 'package:flutter/material.dart';
import 'package:mal3ab/features/Home/presentation/views/home_view.dart';

void main() {
  runApp(Mal3ab());
}

class Mal3ab extends StatelessWidget {
  const Mal3ab({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeView(),
    );
  }
}
