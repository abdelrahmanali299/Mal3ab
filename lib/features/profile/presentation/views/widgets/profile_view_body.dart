import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mal3ab/features/auth/data/model/user_model.dart';
import 'package:mal3ab/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:mal3ab/features/team_players/presentation/views/team_players_view.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key, required this.userModel});
  final UserModel userModel;

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          SizedBox(height: size.height * .08),
          Image.asset('assets/images/3551911.jpg', width: size.width * .4),
          Text(
            widget.userModel.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          Text(
            widget.userModel.isLooged ? 'registerd' : 'not registerd',
            style: TextStyle(
              color: Colors.black.withValues(alpha: .5),
              fontSize: 16,
            ),
          ),
          SizedBox(height: size.height * .03),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Actions',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          SizedBox(height: size.height * .01),
          GestureDetector(
            onTap: () async {
              if (widget.userModel.isLooged) {
                context.read<ProfileCubit>().withdraw(widget.userModel);
              } else {
                context.read<ProfileCubit>().registerPlayer(widget.userModel);
              }
              context.read<ProfileCubit>().update(widget.userModel);

              setState(() {});
            },
            child: widget.userModel.isLooged
                ? Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: .05),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(FontAwesomeIcons.xmark),
                      ),
                      SizedBox(width: size.width * .05),
                      Text(
                        'Withdrow From Match',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: .05),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(FontAwesomeIcons.k),
                      ),
                      SizedBox(width: size.width * .05),
                      Text('register to Match', style: TextStyle(fontSize: 16)),
                    ],
                  ),
          ),
          SizedBox(height: size.height * .02),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => TeamPlayersView()),
              );
            },
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: .1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    FontAwesomeIcons.userGroup,
                    size: size.width * .04,
                  ),
                ),
                SizedBox(width: size.width * .05),
                Text('View Registerd Players', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
