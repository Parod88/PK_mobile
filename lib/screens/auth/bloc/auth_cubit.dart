import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passkey/domain/models/user/user.dart';
import 'package:passkey/screens/auth/bloc/auth_state.dart';
import 'package:passkey/services/auth_service.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService;

  AuthCubit(
    this._authService,
  ) : super(AuthInitial());

  void signIn(String email, String password) async {
    emit(AuthLoading());
    UserModel? user = await _authService.signIn(email, password);

    if (user == null) {
      emit(const AuthError(message: "Sign in failed"));
    } else if (!user.emailIsVerified) {
      emit(const AuthUnverifiedEmail());
    } else {
      emit(const AuthSignInSuccess());
    }
  }

  void signInWithGoogle() async {
    emit(AuthLoading());
    final user = await _authService.signInWithGoogle();

    if (user == null) {
      emit(const AuthError(message: "Sign in failed"));
    } else if (!user.emailIsVerified) {
      emit(const AuthUnverifiedEmail());
    } else {
      emit(const AuthSignInSuccess());
    }
  }

  void signUpWithGoogle() async {
    emit(AuthLoading());

    UserModel? user = await _authService.signUpWithGoogle();

    if (user == null) {
      emit(const AuthError(message: "Sign up failed"));
    } else {
      emit(const AuthSignUpSuccess());
    }
  }

  void signUp(String username, String email, String password) async {
    emit(AuthLoading());

    UserModel? user = await _authService.signUp(username, email, password);

    if (user == null) {
      emit(const AuthError(message: "Sign up failed"));
    } else {
      emit(const AuthSignUpSuccess());
    }
  }

  void logOut() async {
    emit(AuthLoading());
    await _authService.logOut();
    emit(AuthInitial());
  }
}
