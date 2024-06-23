import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_bloc/services/auth_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuthService _authService = FirebaseAuthService();

  AuthBloc() : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    }
    // Handle other events like Login, Logout, etc.
  }

  Stream<AuthState> _mapAppStartedToState() async* {
    try {
      // Check current user authentication status
      User? currentUser = _authService.getCurrentUser();
      if (currentUser != null) {
        yield AuthAuthenticated(currentUser);
      } else {
        yield AuthUnauthenticated();
      }
    } catch (e) {
      yield AuthUnauthenticated();
    }
  }
}
