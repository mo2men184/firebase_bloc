import 'package:firebase_bloc/bloc/auth_bloc.dart';
import 'package:firebase_bloc/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            authBloc.add(AppStarted());
          },
          child: Text('Login'),
        ),
      ),
    );
  }
}
