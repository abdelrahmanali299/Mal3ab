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
          ? Text('You', style: TextStyle(fontWeight: FontWeight.bold))
          : Text(user.name, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text('Registerd'),
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.blue.withValues(alpha: .3),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.asset(user.image, fit: BoxFit.fill),
        ),
      ),
    );
  }
}
