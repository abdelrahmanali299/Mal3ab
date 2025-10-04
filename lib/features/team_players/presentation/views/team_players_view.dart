import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mal3ab/core/data_source/functions/get_dummy_players.dart';
import 'package:mal3ab/features/admin/data/models/match_model.dart';
import 'package:mal3ab/features/team_players/presentation/manager/team_player_cubit.dart';
import 'package:mal3ab/features/team_players/presentation/views/widgets/team_players_view_body.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TeamPlayersView extends StatelessWidget {
  const TeamPlayersView({super.key, required this.match});
  final MatchModel match;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Team Players',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: BlocBuilder<TeamPlayerCubit, TeamPlayerState>(
        builder: (context, state) {
          if (state is GetTeamPlayerSuccess) {
            print('stateeeeeeeeeeee ${state.teamPlayers.length}');
            return TeamPlayersViewBody(users: state.teamPlayers, match: match);
          }
          if (state is GetTeamPlayerFailure) {
            return Center(child: Text(state.message));
          }
          return Skeletonizer(
            child: TeamPlayersViewBody(users: getDummyPlayers(), match: match,),
          );
        },
      ),
    );
  }
}
