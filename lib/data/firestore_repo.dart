import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreRepository {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('your_collection_name');

  Future<List<DocumentSnapshot>> getData() async {
    QuerySnapshot querySnapshot = await _collection.get();
    return querySnapshot.docs;
  }

  Future<DocumentSnapshot> getDocumentById(String id) async {
    DocumentSnapshot documentSnapshot = await _collection.doc(id).get();
    return documentSnapshot;
  }

  Future<void> addDocument(Map<String, dynamic> data) async {
    await _collection.add(data);
  }

  Future<void> updateDocument(String id, Map<String, dynamic> data) async {
    await _collection.doc(id).update(data);
  }

  Future<void> deleteDocument(String id) async {
    await _collection.doc(id).delete();
  }

  // Example of a more complex query
  Future<List<DocumentSnapshot>> getDocumentsWhere(
      String field, dynamic isEqualTo) async {
    QuerySnapshot querySnapshot =
        await _collection.where(field, isEqualTo: isEqualTo).get();
    return querySnapshot.docs;
  }
}
