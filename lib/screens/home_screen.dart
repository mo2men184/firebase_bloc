import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_bloc/bloc/auth_bloc.dart';
import 'package:firebase_bloc/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  final User user;
  HomeScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, ${user.displayName}!'),
            ElevatedButton(
              onPressed: () {
                // Handle logout
                BlocProvider.of<AuthBloc>(context).add(AppStarted());
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
