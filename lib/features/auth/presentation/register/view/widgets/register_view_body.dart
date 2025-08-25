import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mal3ab/features/auth/data/model/user_model.dart';
import 'package:mal3ab/features/auth/presentation/login/views/widgets/custom_botton.dart';
import 'package:mal3ab/features/auth/presentation/login/views/widgets/custom_text_field.dart';
import 'package:mal3ab/features/auth/presentation/register/manager/cubit/register_cubit.dart';
import 'package:mal3ab/features/auth/presentation/register/view/widgets/avatars_list_view.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final imageController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('sign up successfully')));
          Navigator.pop(context);
        }
        if (state is RegisterFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errMessage)));
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is RegisterLooding,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 60),
            child: Form(
              autovalidateMode: autovalidateMode,
              key: formKey,
              child: Column(
                children: [
                  CustomTextField(hint: 'Name', controller: nameController),
                  SizedBox(height: 25),
                  CustomTextField(hint: 'Email', controller: emailController),
                  SizedBox(height: 25),
                  CustomTextField(
                    hint: 'Password',
                    controller: passwordController,
                  ),
                  SizedBox(height: 25),
                  AvatarsListView(),
                  CustomButton(
                    onTap: () {
                      submitRegister(context);
                    },
                    title: 'sign up',
                    color: Colors.black,
                    titleColor: Colors.white,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text('already have an account? login'),
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

  void submitRegister(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      UserModel registerModel = UserModel(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        image: '',
        isLooged: false,
      );
      context.read<RegisterCubit>().signUp(registerModel);
    } else {
      autovalidateMode = AutovalidateMode.always;
      setState(() {});
    }
  }
}
