import 'package:flutter/material.dart';

import 'package:mal3ab/features/admin/presentation/views/widgets/admin_view_body.dart';

class AdminView extends StatelessWidget {
  const AdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: AdminViewBody()));
  }
}
