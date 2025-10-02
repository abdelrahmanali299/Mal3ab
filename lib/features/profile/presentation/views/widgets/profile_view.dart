import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mal3ab/core/cache_helper.dart';
import 'package:mal3ab/core/function/custom_snack_bar.dart';
import 'package:mal3ab/features/admin/presentation/manager/admin_cubit.dart';
import 'package:mal3ab/features/auth/data/model/user_model.dart';
import 'package:mal3ab/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:mal3ab/features/profile/presentation/views/widgets/profile_view_body.dart';
import 'package:mal3ab/features/team_players/presentation/manager/team_player_cubit.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AdminCubit()..getNewestMatch()),
        BlocProvider(create: (context) => ProfileCubit()),
        BlocProvider(
          create: (context) => TeamPlayerCubit()
            ..getTeamPlayers(context.read<AdminCubit>().matchModel.id ?? ''),
        ),
      ],
      child: Scaffold(
        body: BlocListener<AdminCubit, AdminState>(
          listener: (context, state) {
            if (state is GetNewestMatchError) {
              customSnackBar(context, state.failure, Colors.red);
            }
          },
          child: ProfileViewBody(
            userModel: UserModel.fromJson(
              jsonDecode(CacheHelper.getString('user')),
            ),
          ),
        ),
      ),
    );
  }
}
