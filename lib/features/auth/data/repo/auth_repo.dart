import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mal3ab/core/services/failure.dart';

abstract class AuthRepo {
  Future<Either<Failure, User>> login(String userName, String passWord);
}
