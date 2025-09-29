import 'package:dartz/dartz.dart';
import 'package:mal3ab/constants.dart';
import 'package:mal3ab/core/data_source/firestore_service.dart';
import 'package:mal3ab/core/services/failure.dart';
import 'package:mal3ab/features/auth/data/model/user_model.dart';
import 'package:mal3ab/features/profile/data/repo/profile_repo.dart';

class ProfileRepoImpl extends ProfileRepo {
  @override
  Future<Either<Failure, void>> register(UserModel userModel) async {
    try {
      await FirestoreService().addData(
        userModel.id!,
        kPlayersCollection,
        userModel.toJson(),
      );
      userModel.isLooged = true;

      return right(null);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> withdrow(UserModel userModel) async {
    try {
      await FirestoreService().deleteData(userModel.id!, kPlayersCollection);
      userModel.isLooged = false;
      return right(null);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateData(UserModel userModel) async {
    try {
      await FirestoreService().updateData(
        userModel.id!,
        kUSersCollection,
        data: {userModel.isLooged.toString(): userModel.isLooged},
      );
      return right(null);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
