import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mal3ab/features/admin/data/models/match_model.dart';
import 'package:mal3ab/features/auth/data/model/user_model.dart';
import 'package:mal3ab/features/team_players/presentation/views/widgets/player_item.dart';

class TeamPlayersViewBody extends StatelessWidget {
  const TeamPlayersViewBody({
    super.key,
    required this.users,
    required this.match,
  });
  final List<UserModel> users;
  final MatchModel match;
  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd/MM/yyyy').format(match.endDate!);

    return Column(
      children: [
        Text(
          'Match Day:${formattedDate}',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) {
              return PlayerItem(user: users[index]);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 5);
            },
            itemCount: users.length,
          ),
        ),
      ],
    );
  }
}
