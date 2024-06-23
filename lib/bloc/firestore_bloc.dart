// Firestore BLoC
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_bloc/bloc/firestore_event.dart';
import 'package:firebase_bloc/bloc/firestore_state.dart';
import 'package:firebase_bloc/data/firestore_repo.dart';

class FirestoreBloc extends Bloc<FirestoreEvent, FirestoreState> {
  final FirestoreRepository _repository = FirestoreRepository();

  FirestoreBloc() : super(FirestoreLoading());

  @override
  Stream<FirestoreState> mapEventToState(FirestoreEvent event) async* {
    if (event is LoadFirestoreData) {
      yield* _mapLoadFirestoreDataToState();
    }
    // Handle other events
  }

  Stream<FirestoreState> _mapLoadFirestoreDataToState() async* {
    try {
      // Fetch data from Firestore through repository
      List<DocumentSnapshot> data = await _repository.getData();
      yield FirestoreLoaded(data);
    } catch (e) {
      yield FirestoreError(e.toString());
    }
  }
}
