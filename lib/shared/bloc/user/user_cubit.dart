import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passkey/services/user_service.dart';
import 'package:passkey/shared/bloc/user/user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserService _userService;

  UserCubit(
    this._userService,
  ) : super(const UserInitial());

  void updateFavs(String buildingId) async {
    emit(UserLoading());
    await _userService.updateFavs(buildingId);
    emit(const UserUpdateFavsSuccess());
  }

  void getUser() async {
    emit(UserLoading());
    await _userService.getUser();
    emit(const GetUserSuccess());
  }
}
