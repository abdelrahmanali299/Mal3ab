import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:mal3ab/constants.dart';
import 'package:mal3ab/features/auth/data/model/user_model.dart';
import 'package:mal3ab/features/team_players/data/repos/team_player_repo_impl.dart';
import 'package:meta/meta.dart';

part 'team_player_state.dart';

class TeamPlayerCubit extends Cubit<TeamPlayerState> {
  @override
  void onChange(Change<TeamPlayerState> change) {
    log(change.toString());

    super.onChange(change);
  }

  TeamPlayerCubit() : super(TeamPlayerInitial());

  List<UserModel> playersList = [];
  getTeamPlayers() async {
    emit(GetTeamPlayerLoading());
    var res = await TeamPlayerRepoImpl().getAllPlayers(kPlayersCollection);
    res.fold((failure) => emit(GetTeamPlayerFailure(failure.message)), (
      players,
    ) {
      playersList = players;
      emit(GetTeamPlayerSuccess(players));
    });
  }
}
