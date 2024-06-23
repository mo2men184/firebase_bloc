// Define FCM states
import 'package:firebase_messaging/firebase_messaging.dart';

abstract class FCMState {}

class FCMInitial extends FCMState {}

class FCMTokenReceived extends FCMState {
  final String token;
  FCMTokenReceived(this.token);
}

class FCMMessageReceived extends FCMState {
  final RemoteMessage message;
  FCMMessageReceived(this.message);
}
