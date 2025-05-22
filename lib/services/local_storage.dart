import 'package:hive/hive.dart';
import 'package:passkey/domain/models/user/user.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class LocalStorage {
  static final LocalStorage _instance = LocalStorage._internal();

  factory LocalStorage() {
    return _instance;
  }

  LocalStorage._internal();

  late Box _userBox;

  Future<void> init() async {
    // Inicializar Hive
    final appDocumentDir =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);

    // Abrir Box para almacenar datos de usuario
    _userBox = await Hive.openBox('user');
  }

  Future<void> clear() async {
    await _userBox.clear();
  }

  Future<void> setUser(UserModel user) async {
    await _userBox.putAll(user.toFirestore());
  }

  Future<UserModel?> getUser() async {
    try {
      return UserModel.fromMap(_userBox.toMap());
    } catch (e) {
      return null;
    }
  }
}
