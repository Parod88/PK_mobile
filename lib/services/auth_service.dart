import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:passkey/data/repositories/user_repository.dart';
import 'package:passkey/domain/models/user/user.dart';
import 'package:passkey/domain/models/user/user_role.dart';
import 'package:passkey/services/local_storage.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserRepository _userRepository;

  UserModel? user;

  AuthService(
    this._userRepository,
  );

  Future<UserModel?> loadSession() async {
    user = await LocalStorage().getUser();
    return user;
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        // Sign-in was canceled by the user
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (e) {
      return null;
    }
  }

  Future<UserModel?> signInWithGoogle() async {
    try {
      final credentials = await _signInWithGoogle();
      if (credentials == null) return null;

      return _getUserFromCredentials(credentials);
    } on Exception catch (e) {
      return null;
    }
  }

  Future<UserModel?> signUpWithGoogle() async {
    try {
      final credentials = await _signInWithGoogle();
      if (credentials == null) return null;

      return _saveUserFromCredentials(credentials);
    } on Exception catch (e) {
      return null;
    }
  }

  Future<UserModel?> _getUserFromCredentials(UserCredential credentials) async {
    try {
      var user = await _userRepository
          .queryByEmail(credentials.user!.email!.toLowerCase());

      if (user == null) return null;
      if (!user.emailIsVerified && credentials.user!.emailVerified) {
        user = user.verifyEmail();
        await _userRepository.updateUser(user);
      }

      await LocalStorage().setUser(user);
      this.user = user;

      return user;
    } catch (e) {
      return null;
    }
  }

  Future<UserModel?> _saveUserFromCredentials(
    UserCredential credentials,
  ) async {
    final User userFromCredentials = credentials.user!;
    try {
      bool userExists =
          await _userRepository.checkUserExist(userFromCredentials.email!);

      if (userExists) {
        return null;
      }
      UserModel newUser = UserModel(
        id: userFromCredentials.uid,
        email: userFromCredentials.email!,
        username: userFromCredentials.displayName!,
        emailIsVerified: userFromCredentials.emailVerified,
        role: UserRole.user,
        favoriteBuildings: List.empty(growable: true),
      );
      if (userFromCredentials.emailVerified) {
        await LocalStorage().setUser(newUser);
      }
      user = newUser;
      await _userRepository.addUser(newUser);
      return newUser;
    } catch (e) {
      return null;
    }
  }

  Future<UserModel?> signIn(String email, String password) async {
    final String normalizedEmail = email.toLowerCase();
    var user = await _userRepository.queryByEmail(normalizedEmail);
    if (user == null) return null;
    try {
      final UserCredential credentials = await _auth.signInWithEmailAndPassword(
        email: normalizedEmail,
        password: password,
      );

      if (credentials.user == null) return null;

      if (!user.emailIsVerified && credentials.user!.emailVerified) {
        user = user.verifyEmail();
        await _userRepository.updateUser(user);
      }

      await LocalStorage().setUser(user);
      this.user = user;

      return user;
    } catch (e) {
      return null;
    }
  }

  Future<UserModel?> signUp(
      String username, String email, String password) async {
    try {
      bool userExists = await _userRepository.checkUserExist(email);

      if (userExists) {
        return null;
      }

      final UserCredential credentials = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      final User user = credentials.user!;

      UserModel newUser = UserModel(
        id: user.uid,
        email: email,
        username: username,
        emailIsVerified: false,
        role: UserRole.user,
        favoriteBuildings: List.empty(growable: true),
      );

      await _userRepository.addUser(newUser);

      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      this.user = newUser;
      return this.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // onError('The password provided is too weak');
        return null;
      } else if (e.code == 'email-already-in-use') {
        // onError('The account already exists for that email');
        return null;
      } else {
        // onError(e.toString());
        return null;
      }
    } catch (e) {
      // onError('An error occurred');
      return null;
    }
  }

  Future<void> logOut() async {
    await _auth.signOut();
    await LocalStorage().clear();
    user = null;
  }

  Future<void> getUser() async {
    if (user == null) return;
    user = await _userRepository.getUser(user!.id);
    await LocalStorage().setUser(user!);
  }
}
