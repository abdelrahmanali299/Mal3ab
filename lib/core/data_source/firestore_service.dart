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

  Future<Map<String, dynamic>> getData(
    String mainId,
    String mainPath, {
    Map<String, dynamic>? query,
  }) async {
    if (query?['where'] != null) {
      var res = await _firestore
          .collection(mainPath)
          .where('name', isEqualTo: query?['where'])
          .get();
      return res.docs.first.data();
    }
    var res = await _firestore.collection(mainPath).doc(mainId).get();

    return res.data() ?? {};
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
}
