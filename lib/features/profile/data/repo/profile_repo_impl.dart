import 'package:dartz/dartz.dart';
import 'package:mal3ab/constants.dart';
import 'package:mal3ab/core/data_source/firestore_service.dart';
import 'package:mal3ab/core/services/failure.dart';
import 'package:mal3ab/features/admin/data/models/match_model.dart';
import 'package:mal3ab/features/auth/data/model/user_model.dart';
import 'package:mal3ab/features/profile/data/repo/profile_repo.dart';

class ProfileRepoImpl extends ProfileRepo {
  @override
  Future<Either<Failure, void>> register(
    UserModel userModel,
    String mainId,
  ) async {
    try {
      userModel.isLooged = true;

      await FirestoreService().addData(
        mainId,
        kMatchesCollection,
        userModel.toJson(),
      );

      return right(null);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> withdrow(
    UserModel userModel,
    String mainId,
  ) async {
    try {
      userModel.isLooged = false;

      await FirestoreService().deleteData(mainId, kMatchesCollection);
      return right(null);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateData({
    required String mainId,
    required String collection,
    required Map<String, dynamic> data,
  }) async {
    try {
      await FirestoreService().updateData(mainId, collection, data: data);
      return right(null);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
