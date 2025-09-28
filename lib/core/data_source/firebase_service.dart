import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<UserCredential> signup({
    required String mainPath,
    required String username,
    required String email,
    required String password,
    required String userId,
    required bool registerd,
  }) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await _firestore.collection(mainPath).doc(userId).set({
      "username": username,
      "email": email,
      "registerd": registerd,
    });
    return userCredential;
  }

  Future<UserCredential> signInWithUsername({
    required String mainPath,
    required String username,
    required String password,
  }) async {
    try {
      final query = await _firestore
          .collection(mainPath)
          .where('username', isEqualTo: username)
          .limit(1)
          .get();
      final email = query.docs.first['email'] as String;
      return _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
}
