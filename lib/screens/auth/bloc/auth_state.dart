import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthSignUpSuccess extends AuthState {
  const AuthSignUpSuccess();

  @override
  List<Object?> get props => [];
}

class AuthSignInSuccess extends AuthState {
  const AuthSignInSuccess();

  @override
  List<Object?> get props => [];
}

class AuthError extends AuthState {
  final String message;
  const AuthError({required this.message});

  @override
  List<Object?> get props => [message];
}

class AuthUnverifiedEmail extends AuthState {
  const AuthUnverifiedEmail();

  @override
  List<Object?> get props => [];
}
