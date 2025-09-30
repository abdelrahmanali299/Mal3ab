import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mal3ab/features/auth/data/model/user_model.dart';

class PlayerItem extends StatelessWidget {
  const PlayerItem({super.key, required this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: FirebaseAuth.instance.currentUser?.email == user.email
          ? Text('You')
          : Text(user.name),
      subtitle: Text('Registerd'),
      leading: CircleAvatar(child: Image.asset(user.image)),
    );
  }
}
