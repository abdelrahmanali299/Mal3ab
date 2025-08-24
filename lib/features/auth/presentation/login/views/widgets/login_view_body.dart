import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mal3ab/features/auth/data/repo/auth_repo_impl.dart';
import 'package:mal3ab/features/auth/presentation/login/manager/cubit/login_cubit.dart';
import 'package:mal3ab/features/auth/presentation/login/views/widgets/custom_botton.dart';
import 'package:mal3ab/features/auth/presentation/login/views/widgets/custom_text_field.dart';
import 'package:mal3ab/features/auth/presentation/register/manager/cubit/register_cubit.dart';
import 'package:mal3ab/features/auth/presentation/register/view/register_view.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('logged in successfully')));

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (context) => LayoutCubit(),
                child: LayoutView(),
              ),
            ),
          );
        }
        if (state is LoginFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('logged in failure')));
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is LoginLooding,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 60),
            child: Form(
              autovalidateMode: autovalidateMode,
              key: formKey,
              child: Column(
                children: [
                  CustomTextField(
                    hint: 'UserName',
                    onChanged: (data) {
                      nameController.text = data;
                    },
                  ),
                  SizedBox(height: 25),
                  CustomTextField(
                    hint: 'password',
                    onChanged: (data) {
                      passwordController.text = data;
                    },
                  ),
                  SizedBox(height: 25),

                  CustomButton(
                    onTap: () {
                      submitLogin(context);
                    },
                    title: 'login',
                    color: Colors.black,
                    titleColor: Colors.white,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider(
                                create: (context) =>
                                    RegisterCubit(AuthRepoImpl()),
                                child: RegisterView(),
                              ),
                            ),
                          );
                        },
                        child: Text('dont have an account? Register'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void submitLogin(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      context.read<LoginCubit>().loginUSer(
        nameController.text,
        passwordController.text,
      );
    } else {
      autovalidateMode = AutovalidateMode.always;
      setState(() {});
    }
  }
}
