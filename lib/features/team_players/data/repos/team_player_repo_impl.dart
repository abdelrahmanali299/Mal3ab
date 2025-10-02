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
    String mainId,
  ) async {
    try {
      var res = await _firestoreService.getData(mainId, mainPath);
      if (res?['players'] == null) return right([]);
      // i want to get all player from the matches collection that contain the match model that contain the players that list of usermodel and return them as a list of UserModels
      List<UserModel> players = [];
      for (var player in res?['players']) {
        players.add(UserModel.fromJson(player));
      }
      return right(players);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
