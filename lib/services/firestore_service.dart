import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<DocumentSnapshot>> getData() async {
    QuerySnapshot querySnapshot =
        await _firestore.collection('your_collection').get();
    return querySnapshot.docs;
  }
}
