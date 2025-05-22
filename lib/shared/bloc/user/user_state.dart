import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  const UserInitial();
  @override
  List<Object?> get props => [];
}

class UserLoading extends UserState {
  @override
  List<Object> get props => [];
}

class UserUpdateFavsSuccess extends UserState {
  const UserUpdateFavsSuccess();

  @override
  List<Object?> get props => [];
}

class GetUserSuccess extends UserState {
  const GetUserSuccess();

  @override
  List<Object?> get props => [];
}
