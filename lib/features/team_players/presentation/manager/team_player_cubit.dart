import 'package:bloc/bloc.dart';
import 'package:mal3ab/constants.dart';
import 'package:mal3ab/features/auth/data/model/user_model.dart';
import 'package:mal3ab/features/team_players/data/repos/team_player_repo_impl.dart';
import 'package:meta/meta.dart';

part 'team_player_state.dart';

class TeamPlayerCubit extends Cubit<TeamPlayerState> {
  TeamPlayerCubit() : super(TeamPlayerInitial());

  getTeamPlayers() async {
    emit(GetTeamPlayerLoading());
    var res = await TeamPlayerRepoImpl().getAllPlayers(kPlayersCollection);
    res.fold(
      (failure) => emit(GetTeamPlayerFailure(failure.message)),
      (players) => emit(GetTeamPlayerSuccess(players)),
    );
  }
}
