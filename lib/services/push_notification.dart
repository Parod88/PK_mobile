import 'package:firebase_core/firebase_core.dart';
import 'package:passkey/firebase_options.dart';

class PushNotificationService {
  static String? token;

  static Future initializeApp() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    // await _firebaseMessaging.requestPermission();
    // token = await _firebaseMessaging.getToken();
  }
}
