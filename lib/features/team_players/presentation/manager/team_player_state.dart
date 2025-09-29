part of 'team_player_cubit.dart';

@immutable
abstract class TeamPlayerState {}

class TeamPlayerInitial extends TeamPlayerState {}

class GetTeamPlayerLoading extends TeamPlayerState {}

class GetTeamPlayerSuccess extends TeamPlayerState {
  final List<UserModel> teamPlayers;
  GetTeamPlayerSuccess(this.teamPlayers);
}

class GetTeamPlayerFailure extends TeamPlayerState {
  final String message;
  GetTeamPlayerFailure(this.message);
}
