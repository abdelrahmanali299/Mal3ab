import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mal3ab/constants.dart';
import 'package:mal3ab/core/data_source/firestore_service.dart';
import 'package:mal3ab/features/auth/data/model/user_model.dart';
import 'package:mal3ab/features/profile/presentation/manager/cubit/profile_cubit.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key, required this.userModel});
  final UserModel userModel;

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  bool isPlayerregisterd = false;

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
            'moaz waleed',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          Text(
            'registerd player',
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
              isPlayerregisterd = await isPlayerRegisterd();

              if (isPlayerregisterd) {
                context.read<ProfileCubit>().wirh(widget.userModel.id!);
              } else {
                context.read<ProfileCubit>().registerPlayer(widget.userModel);
              }
              isPlayerregisterd = await isPlayerRegisterd();
              setState(() {});
            },
            child: isPlayerregisterd
                ? Row(
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
                        child: Icon(FontAwesomeIcons.xmark),
                      ),
                      SizedBox(width: size.width * .05),
                      Text(
                        'Withdrow From Match',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
          ),
          SizedBox(height: size.height * .02),
          GestureDetector(
            onTap: () {},
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

  Future<bool> isPlayerRegisterd() async {
    try {
      var res = await FirestoreService().getData(
        widget.userModel.id!,
        kPlayersCollection,
      );
      if (res.isEmpty) {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
