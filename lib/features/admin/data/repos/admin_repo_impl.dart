import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:mal3ab/constants.dart';
import 'package:mal3ab/core/cache_helper.dart';
import 'package:mal3ab/core/data_source/firestore_service.dart';
import 'package:mal3ab/core/services/failure.dart';
import 'package:mal3ab/features/admin/data/models/match_model.dart';
import 'package:mal3ab/features/admin/data/repos/admin_repo.dart';
import 'package:mal3ab/features/auth/data/model/user_model.dart';

class AdminRepoImpl extends AdminRepo {
  @override
  Future<Either<Failure, void>> addMatch({
    required MatchModel matchModel,
    required String mainId,
    required String mainPath,
  }) async {
    try {
      await FirestoreService().addData(mainId, mainPath, matchModel.toJson());
      var res = await FirestoreService().getAllData(kUSersCollection);
      for (var user in res) {
        await FirestoreService().updateData(
          user['id'],
          kUSersCollection,
          data: {'isLooged': false},
        );
      }
      UserModel userModel = UserModel.fromJson(
        jsonDecode(CacheHelper.getString('user')),
      );
      userModel.isLooged = false;
      CacheHelper.setString('user', jsonEncode(userModel.toJson()));
      return right(null);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, MatchModel?>> getNewestMatch(String mainPath) async {
    try {
      var res = await FirestoreService().getData(
        '',
        mainPath,
        query: {'orderBy': 'startDate', 'desc': true},
      );
      if (res == null) {
        return right(null);
      }
      return right(MatchModel.fromJson(res ?? {}));
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
