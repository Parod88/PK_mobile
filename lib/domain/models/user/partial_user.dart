import 'package:passkey/domain/models/user/user.dart';

class PartialUser {
  final String id;
  final String email;
  PartialUser({
    required this.id,
    required this.email,
  });

  factory PartialUser.initialize(UserModel user) {
    return PartialUser(id: user.id, email: user.email);
  }

  factory PartialUser.fromMap(Map<String, dynamic> map) {
    return PartialUser(id: map['id'], email: map['email']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
    };
  }
}
