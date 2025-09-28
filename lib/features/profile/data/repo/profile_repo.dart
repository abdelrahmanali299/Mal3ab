import 'package:dartz/dartz.dart';
import 'package:mal3ab/core/services/failure.dart';
import 'package:mal3ab/features/auth/data/model/user_model.dart';

abstract class ProfileRepo {
  Future<Either<Failure, UserModel>> register();
  Future<Either<Failure, void>> withdrow();
}
