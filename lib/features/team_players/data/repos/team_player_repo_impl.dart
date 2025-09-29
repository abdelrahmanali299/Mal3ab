import 'package:dartz/dartz.dart';
import 'package:mal3ab/core/data_source/firestore_service.dart';
import 'package:mal3ab/core/services/failure.dart';
import 'package:mal3ab/features/auth/data/model/user_model.dart';
import 'package:mal3ab/features/team_players/data/repos/team_player_repo.dart';

class TeamPlayerRepoImpl extends TeamPlayerRepo {
  FirestoreService _firestoreService = FirestoreService();
  @override
  Future<Either<Failure, List<UserModel>>> getAllPlayers(
    String mainPath,
  ) async {
    try {
      var res = await _firestoreService.getAllData(mainPath);
      return right(res.map((e) => UserModel.fromJson(e)).toList());
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
