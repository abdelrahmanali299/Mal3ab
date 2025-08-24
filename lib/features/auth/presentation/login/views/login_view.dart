import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mal3ab/features/auth/data/repo/auth_repo_impl.dart';
import 'package:mal3ab/features/auth/presentation/login/manager/cubit/login_cubit.dart';
import 'package:mal3ab/features/auth/presentation/login/views/widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginCubit(AuthRepoImpl()),
        child: LoginViewBody(),
      ),
    );
  }
}
