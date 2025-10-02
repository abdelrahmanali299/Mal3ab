import 'package:dartz/dartz.dart';
import 'package:mal3ab/core/services/failure.dart';
import 'package:mal3ab/features/auth/data/model/user_model.dart';

abstract class ProfileRepo {
  Future<Either<Failure, void>> register(UserModel userModel, String mainId);
  Future<Either<Failure, void>> withdrow(UserModel userModel, String mainId);
  Future<Either<Failure, void>> updateData({
    required String mainId,
    required String collection,
    required Map<String, dynamic> data,
  });
  Future<Either<Failure, UserModel>> getUserModel(String mainId);
}
