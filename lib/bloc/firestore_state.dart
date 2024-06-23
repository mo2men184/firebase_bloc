import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirestoreState {}

class FirestoreLoading extends FirestoreState {}

class FirestoreLoaded extends FirestoreState {
  final List<DocumentSnapshot> documents;
  FirestoreLoaded(this.documents);
}

class FirestoreError extends FirestoreState {
  final String message;
  FirestoreError(this.message);
}
