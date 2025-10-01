import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mal3ab/core/function/custom_snack_bar.dart';
import 'package:mal3ab/features/auth/data/model/user_model.dart';
import 'package:mal3ab/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:mal3ab/features/profile/presentation/views/widgets/alert_dialog.dart';
import 'package:mal3ab/features/profile/presentation/views/widgets/register_or_withdraw_button.dart';
import 'package:mal3ab/features/team_players/presentation/manager/team_player_cubit.dart';
import 'package:mal3ab/features/team_players/presentation/views/team_players_view.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key, required this.userModel});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            customSnackBar(context, 'Register successfully', Colors.green);
          } else if (state is WithdrawSuccess) {
            customSnackBar(context, 'Withdraw successfully', Colors.red);
          } else if (state is RegisterFailure) {
            customSnackBar(context, 'Register Failure', Colors.red);
          } else if (state is WithdrawFailure) {
            customSnackBar(context, 'Withdraw Failure', Colors.red);
          }
        },
        builder: (context, state) {
          if (state is RegisterLoading || state is WithdrawLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final bool isRegistered =
              userModel.isLooged || state is RegisterSuccess;
          final String buttonTitle = isRegistered
              ? 'Withdraw From Match'
              : 'Register To Match';
          final IconData buttonIcon = isRegistered
              ? FontAwesomeIcons.xmark
              : FontAwesomeIcons.check;

          return Column(
            children: [
              SizedBox(height: size.height * .08),
              Flexible(
                child: Image.asset(userModel.image, width: size.width * .4),
              ),
              Text(
                userModel.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              Text(
                isRegistered ? 'registered' : 'not registered',
                style: TextStyle(
                  color: Colors.black.withValues(alpha: .5),
                  fontSize: 16,
                ),
              ),
              SizedBox(height: size.height * .03),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Actions',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              SizedBox(height: size.height * .01),
              GestureDetector(
                onTap: () {
                  if (isRegistered) {
                    showDialog(
                      context: context,
                      builder: (dialogContext) => AlertDialogMessage(
                        onConfirm: () {
                          context.read<ProfileCubit>().withdraw(userModel);
                          context.read<ProfileCubit>().update(userModel);
                        },
                        title: 'Withdraw',
                        content:
                            'Are you sure you want to withdraw from the match? ',
                      ),
                    );
                  } else {
                    if (context.read<TeamPlayerCubit>().playersList.length ==
                        10) {
                      customSnackBar(context, 'Team is full', Colors.red);
                    } else {
                      context.read<ProfileCubit>().registerPlayer(userModel);
                      context.read<ProfileCubit>().update(userModel);
                    }
                  }
                },
                child: RegisterOrWithdrawButton(
                  size: size,
                  title: buttonTitle,
                  icon: buttonIcon,
                ),
              ),
              SizedBox(height: size.height * .03),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<TeamPlayerCubit>()
                          ..getTeamPlayers(),
                        child: TeamPlayersView(),
                      ),
                    ),
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
                        color: Colors.blue,
                        FontAwesomeIcons.userGroup,
                        size: size.width * .04,
                      ),
                    ),
                    SizedBox(width: size.width * .05),
                    const Text(
                      'View Registered Players',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
