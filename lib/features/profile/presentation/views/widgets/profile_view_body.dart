import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mal3ab/constants.dart';
import 'package:mal3ab/core/function/custom_snack_bar.dart';
import 'package:mal3ab/features/admin/presentation/manager/admin_cubit.dart';
import 'package:mal3ab/features/admin/presentation/views/admin_view.dart';
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
      child: BlocConsumer<AdminCubit, AdminState>(
        listener: (context, state) {
          if (state is GetNewestMatchError) {
            customSnackBar(context, state.failure, Colors.red);
          }
        },
        builder: (context, adminState) {
          final adminCubit = context.read<AdminCubit>();

          if (adminState is GetNewestMatchLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (adminState is GetNewestMatchEmpty) {
            if (userModel.email == 'bxjdjxk@gmail.com') {
              return Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (innerContext) => BlocProvider.value(
                          value: context.read<AdminCubit>(),
                          child: const AdminView(),
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
                          color: Colors.black.withOpacity(.05),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.admin_panel_settings_outlined,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(width: size.width * .05),
                      const Text(
                        'Admin Panel',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const Center(
              child: Text(
                'No match available yet',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            );
          }

          if (adminCubit.matchModel.id == null) {
            return const Center(
              child: Text('No match found', style: TextStyle(fontSize: 18)),
            );
          }

          final bool isRegistered =
              adminCubit.matchModel.players?.any(
                (player) => player.id == userModel.id,
              ) ??
              false;

          final String buttonTitle = isRegistered
              ? 'Withdraw From Match'
              : 'Register To Match';
          final IconData buttonIcon = isRegistered
              ? FontAwesomeIcons.xmark
              : FontAwesomeIcons.check;

          return BlocConsumer<ProfileCubit, ProfileState>(
            buildWhen: (previous, current) =>
                current is RegisterSuccess ||
                current is RegisterFailure ||
                current is WithdrawSuccess ||
                current is WithdrawFailure ||
                current is RegisterLoading ||
                current is WithdrawLoading,
            listener: (context, state) {
              if (state is RegisterSuccess) {
                customSnackBar(
                  context,
                  'Registered successfully',
                  Colors.green,
                );
              } else if (state is RegisterFailure) {
                customSnackBar(context, 'Register Failure', Colors.red);
              } else if (state is WithdrawSuccess) {
                customSnackBar(context, 'Withdraw successfully', Colors.green);
              } else if (state is WithdrawFailure) {
                customSnackBar(context, 'Withdraw Failure', Colors.red);
              }
            },
            builder: (context, state) {
              if (state is RegisterLoading || state is WithdrawLoading) {
                return const Center(child: CircularProgressIndicator());
              }

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
                      color: Colors.black.withOpacity(.5),
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: size.height * .03),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Actions',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * .01),
                  GestureDetector(
                    onTap: () {
                      if (isRegistered) {
                        // Withdraw
                        showDialog(
                          context: context,
                          builder: (dialogContext) => AlertDialogMessage(
                            onConfirm: () {
                              if (adminCubit.matchModel.endDate?.isAfter(
                                    DateTime.now(),
                                  ) ??
                                  false) {
                                context.read<ProfileCubit>().withdraw(
                                  adminCubit.matchModel.id ?? '',
                                  {
                                    'players': FieldValue.arrayRemove([
                                      userModel.toJson(),
                                    ]),
                                  },
                                );
                                context.read<ProfileCubit>().updateUser(
                                  mainId: userModel.id ?? '',
                                  collection: kUSersCollection,
                                  data: {'isLooged': false},
                                );
                                adminCubit.getNewestMatch();
                              }
                            },
                            title: 'Withdraw',
                            content:
                                'Are you sure you want to withdraw from the match?',
                          ),
                        );
                      } else {
                        // Register
                        if (context
                                .read<TeamPlayerCubit>()
                                .playersList
                                .length ==
                            10) {
                          customSnackBar(context, 'Team is full', Colors.red);
                        } else {
                          if (adminCubit.matchModel.endDate?.isAfter(
                                DateTime.now(),
                              ) ??
                              false) {
                            context.read<ProfileCubit>().registerPlayer(
                              adminCubit.matchModel.id ?? '',
                              {
                                'players': FieldValue.arrayUnion([
                                  userModel.toJson(),
                                ]),
                              },
                            );
                            context.read<ProfileCubit>().updateUser(
                              mainId: userModel.id ?? '',
                              collection: kUSersCollection,
                              data: {'isLooged': true},
                            );
                            adminCubit.getNewestMatch();
                          }
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
                          builder: (innerContext) => BlocProvider.value(
                            value: context.read<TeamPlayerCubit>()
                              ..getTeamPlayers(adminCubit.matchModel.id ?? ''),
                            child: const TeamPlayersView(),
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
                            color: Colors.black.withOpacity(.1),
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
                  SizedBox(height: size.height * .03),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (innerContext) => BlocProvider.value(
                            value: context.read<AdminCubit>(),
                            child: const AdminView(),
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
                            color: Colors.black.withOpacity(.05),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.admin_panel_settings_outlined,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(width: size.width * .05),
                        const Text(
                          'Admin Panel',
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
          );
        },
      ),
    );
  }
}
