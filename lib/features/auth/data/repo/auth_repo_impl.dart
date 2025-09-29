import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mal3ab/core/data_source/firestore_service.dart';
import 'package:mal3ab/core/services/failure.dart';
import 'package:mal3ab/features/auth/data/model/user_model.dart';
import 'package:mal3ab/features/auth/data/repo/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  @override
  Future<Either<Failure, User>> login(String userName, String password) async {
    try {
      final snapshot = await FirestoreService().getData(
        '',
        'users',
        query: {'where': userName},
      );
      if (snapshot.isEmpty) {
        return left(Failure(message: 'Username not found.'));
      }

      final email = snapshot['email'] as String;

      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(credential.user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return left(Failure(message: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        return left(Failure(message: 'Wrong password provided for that user.'));
      } else {
        return left(Failure(message: 'user error'));
      }
    }
  }

  @override
  Future<Either<Failure, void>> signUp(UserModel userModel) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        password: userModel.password ?? '',
        email: userModel.email,
      );

      await FirestoreService().addData(
        userModel.id!,
        'users',
        userModel.toJson(),
      );

      return right(null);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return left(Failure(message: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        return left(
          Failure(message: 'The account already exists for that email.'),
        );
      } else {
        return left(
          Failure(
            message: 'FirebaseAuth error: ${e.message ?? 'Unknown error'}',
          ),
        );
      }
    } catch (e) {
      if (FirebaseAuth.instance.currentUser != null) {
        await FirebaseAuth.instance.currentUser!.delete();
      }
      return left(Failure(message: e.toString()));
    }
  }
}
