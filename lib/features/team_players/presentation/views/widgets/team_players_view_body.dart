import 'package:flutter/material.dart';
import 'package:mal3ab/features/auth/data/model/user_model.dart';
import 'package:mal3ab/features/team_players/presentation/views/widgets/player_item.dart';

class TeamPlayersViewBody extends StatelessWidget {
  const TeamPlayersViewBody({super.key, required this.users});
  final List<UserModel> users;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return PlayerItem(user: users[index]);
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 5);
      },
      itemCount: users.length,
    );
  }
}
