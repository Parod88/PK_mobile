import 'package:passkey/data/repositories/user_repository.dart';
import 'package:passkey/services/auth_service.dart';

class UserService {
  final AuthService _authService;
  final UserRepository _userRepository;

  const UserService(
    this._userRepository,
    this._authService,
  );

  Future<List<String>> updateFavs(String building) async {
    final user = _authService.user;
    if (user == null) return [];

    if (!user.favoriteBuildings.contains(building)) {
      user.addFav(building);
    } else {
      user.removeFav(building);
    }

    await _userRepository.updateUser(user);
    return user.favoriteBuildings;
  }

  Future<void> getUser() async {
    _authService.getUser();
  }
}
