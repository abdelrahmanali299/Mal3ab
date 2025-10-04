import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:mal3ab/core/cache_helper.dart';
import 'package:mal3ab/core/function/custom_snack_bar.dart';
import 'package:mal3ab/core/widgets/dont_have_account.dart';
import 'package:mal3ab/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:mal3ab/features/profile/presentation/views/widgets/profile_view.dart';
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
          customSnackBar(context, 'logged in successfully', Colors.green);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (context) => ProfileCubit(),
                child: ProfileView(),
              ),
            ),
          );
        }
        if (state is LoginFailure) {
          customSnackBar(context, state.errMessage, Colors.red);
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.sizeOf(context).height * .05),
                    Lottie.asset(
                      'assets/images/Contract Sign.json',
                      height: 200.h,
                      width: 200.w,
                    ),
                    CustomTextField(
                      hint: 'UserName',
                      onChanged: (data) {
                        nameController.text = data;
                      },
                    ),
                    SizedBox(height: 25),
                    CustomTextField(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      isPassword: true,
                      hint: 'password',
                      onChanged: (data) {
                        passwordController.text = data;
                      },
                    ),
                    SizedBox(height: 25),

                    CustomButton(
                      onTap: () {
                        CacheHelper.setBool('login', true);
                        submitLogin(context);
                      },
                      title: 'login',
                      color: Colors.blue,
                      titleColor: Colors.white,
                    ),
                    SizedBox(height: 10),
                    DontHaveAccount(
                      text: 'Don\'t have an account? ',
                      subText: 'register',
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
                    ),
                  ],
                ),
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
        nameController.text.trim(),
        passwordController.text.trim(),
      );
    } else {
      autovalidateMode = AutovalidateMode.always;
      setState(() {});
    }
  }
}
