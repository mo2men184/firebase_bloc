import 'package:firebase_bloc/bloc/fcm_event.dart';
import 'package:firebase_bloc/bloc/fcm_state.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FCMBloc extends Bloc<FCMEvent, FCMState> {
  final FirebaseMessagingService _messagingService = FirebaseMessagingService();

  FCMBloc() : super(FCMInitial()) {
    on<InitFCM>(_initFCM);
  }

  Stream<FCMState> _initFCM(InitFCM event, Emitter<FCMState> emit) async* {
    try {
      // Initialize Firebase Messaging
      await _messagingService.initFCM();

      // Retrieve and listen to FCM token changes
      String token = await _messagingService.getFCMToken();
      yield FCMTokenReceived(token);

      // Handle incoming messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        emit(FCMMessageReceived(message));
      });
    } catch (e) {
      print('Error initializing FCM: $e');
    }
  }
}
