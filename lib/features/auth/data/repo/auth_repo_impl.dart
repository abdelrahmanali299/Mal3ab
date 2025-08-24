import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mal3ab/core/services/failure.dart';
import 'package:mal3ab/features/auth/data/repo/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  @override
  Future<Either<Failure, User>> login(String userName, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userName,
        password: password,
      );
      return right(credential.user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return left(Failure(message: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        return Left(Failure(message: 'Wrong password provided for that user.'));
      } else {
        return left(Failure(message: 'user error'));
      }
    }
  }

  @override
  Future<Either<Failure, void>> signUp(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
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
      return left(Failure(message: 'ther was an error'));
    }
  }
}
