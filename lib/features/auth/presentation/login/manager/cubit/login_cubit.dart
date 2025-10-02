import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mal3ab/core/cache_helper.dart';
import 'package:mal3ab/features/auth/data/model/user_model.dart';
import 'package:mal3ab/features/auth/data/repo/auth_repo.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authRepo) : super(LoginInitial());
  final AuthRepo authRepo;
  Future<void> loginUSer(String userName, password) async {
    emit(LoginLooding());
    final result = await authRepo.login(userName, password);

    result.fold(
      (failure) {
        emit(LoginFailure(errMessage: failure.message));
      },
      (user) {
        CacheHelper.setString('user', jsonEncode(user.toJson()));
        emit(LoginSuccess(user: user));
      },
    );
  }
}
