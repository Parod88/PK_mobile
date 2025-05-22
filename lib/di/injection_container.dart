import 'package:get_it/get_it.dart';
import 'package:passkey/data/repositories/bookings_repository.dart';
import 'package:passkey/data/repositories/building_repository.dart';
import 'package:passkey/data/repositories/user_repository.dart';
import 'package:passkey/services/bookings_service.dart';
import 'package:passkey/services/building_service.dart';
import 'package:passkey/services/user_service.dart';
import 'package:passkey/services/auth_service.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // Repositories
  getIt.registerLazySingleton(() => UserRepository());
  getIt.registerLazySingleton(() => BuildingRepository());
  getIt.registerLazySingleton(() => BookingRepository());

  // Data sources

  // Shared Preferences

  // Api service

  // Api service
  getIt.registerLazySingleton(() => BookingService(getIt(), getIt()));
  getIt.registerLazySingleton(() => BuildingService(getIt()));
  getIt.registerLazySingleton(() => UserService(getIt(), getIt()));
  getIt.registerLazySingleton(() => AuthService(getIt()));
}
