import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mal3ab/core/services/failure.dart';
import 'package:mal3ab/features/auth/data/model/user_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserModel>> login(String userName, String passWord);
  Future<Either<Failure, void>> signUp(UserModel userModel);
}
