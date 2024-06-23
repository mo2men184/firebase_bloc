import 'package:firebase_bloc/bloc/auth_bloc.dart';
import 'package:firebase_bloc/bloc/auth_state.dart';
import 'package:firebase_bloc/bloc/fcm_bloc.dart';
import 'package:firebase_bloc/bloc/fcm_event.dart';
import 'package:firebase_bloc/bloc/firestore_bloc.dart';
import 'package:firebase_bloc/bloc/firestore_event.dart';
import 'package:firebase_bloc/services/fcm_service.dart';
import 'package:firebase_bloc/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase BLoC Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => AuthBloc(),
        child: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<FirestoreBloc>(
                create: (context) => FirestoreBloc(
                  firestoreService: FirebaseFirestoreService(),
                )..add(LoadFirestoreData()),
              ),
              BlocProvider<FCMBloc>(
                create: (context) => FCMBloc(
                  messagingService: FirebaseMessagingService(),
                )..add(InitFCM()),
              ),
            ],
            child: HomeScreen(user: state.user),
          );
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
