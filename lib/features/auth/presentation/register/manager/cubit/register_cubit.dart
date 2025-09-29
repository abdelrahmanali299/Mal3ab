import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mal3ab/core/cache_helper.dart';
import 'package:mal3ab/features/auth/data/model/user_model.dart';
import 'package:mal3ab/features/auth/data/repo/auth_repo.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.authRepo) : super(RegisterInitial());
  final AuthRepo authRepo;
  Image image = Image.asset('assets/images/3551911.jpg');
  Future<void> signUp(UserModel userModel) async {
    Image image = Image.asset('assets/images/3551911.jpg');
    AssetImage imageUrl = image.image as AssetImage;

    userModel.image = imageUrl.assetName;

    emit(RegisterLooding());
    final result = await authRepo.signUp(userModel);
    result.fold(
      (failure) {
        emit(RegisterFailure(errMessage: failure.message));
      },
      (success) {
        CacheHelper.setString('user', jsonEncode(userModel.toJson()));
        emit(RegisterSuccess(userModel: userModel));
      },
    );
  }
}
