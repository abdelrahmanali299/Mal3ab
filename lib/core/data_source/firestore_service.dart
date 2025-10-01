import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getDataFromSubCollection(
    String mainId,
    String mainPath,
    String subPath,
  ) async {
    var res = await _firestore
        .collection(mainPath)
        .doc(mainId)
        .collection(subPath)
        .get();
    return res.docs.map((e) {
      return e.data();
    }).toList();
  }

  Future<void> addDataToSubCollection(
    String mainId,
    String subId,
    String mainPath,
    String subPath,
    Map<String, dynamic> data,
  ) async {
    await _firestore
        .collection(mainPath)
        .doc(mainId)
        .collection(subPath)
        .doc(subId)
        .set(data);
  }

  Future<void> addData(
    String mainId,
    String mainPath,
    Map<String, dynamic> data,
  ) async {
    await _firestore.collection(mainPath).doc(mainId).set(data);
  }

  Future<Map<String, dynamic>?> getData(
    String mainId,
    String mainPath, {
    Map<String, dynamic>? query,
  }) async {
    if (query?['where'] != null) {
      var res = await _firestore
          .collection(mainPath)
          .where('name', isEqualTo: query?['where'])
          .get();
      if (res.docs.isEmpty) {
        return null;
      }
      return res.docs.first.data();
    }
    var res = await _firestore.collection(mainPath).doc(mainId).get();

    return res.data() ?? {};
  }

  Future<List<Map<String, dynamic>>> getAllData(String mainPath) async {
    var res = await _firestore.collection(mainPath).get();
    return res.docs.map((e) => e.data()).toList();
  }

  Future<void> deleteDataToSubCollection(
    String mainId,
    String subId,
    String mainPath,
    String subPath,
  ) async {
    await _firestore
        .collection(mainPath)
        .doc(mainId)
        .collection(subPath)
        .doc(subId)
        .delete();
  }

  Future<void> deleteData(String mainId, String mainPath) async {
    await _firestore.collection(mainPath).doc(mainId).delete();
  }

  Future<void> updateData(
    String mainId,
    String mainPath, {
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    if (query?['where'] != null) {
      var snapshot = await _firestore
          .collection(mainPath)
          .where('name', isEqualTo: query?['where'])
          .get();

      for (var doc in snapshot.docs) {
        await doc.reference.update(data ?? {});
      }
    }

    var docRef = _firestore.collection(mainPath).doc(mainId);

    await docRef.update(data ?? {});
  }

  Future<bool> isUserExist(String userName, String mainPath) async {
    var res = await _firestore.collection(mainPath).get();
    if (res.docs.isEmpty) return false;
    for (var user in res.docs) {
      if (user.data()['name'] == userName) {
        return true;
      }
    }
    return false;
  }
}
