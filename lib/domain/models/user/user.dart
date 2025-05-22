import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:passkey/domain/models/user/user_role.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String username;
  final String? surname;
  final String? dni;
  final String? address;
  final String? city;
  final String? photo;
  final UserRole role;
  final DateTime createdAt;
  final List<String> favoriteBuildings;
  final String? stripeCustomerId;
  final bool emailIsVerified;

  UserModel({
    required this.id,
    required this.email,
    required this.username,
    this.stripeCustomerId,
    this.emailIsVerified = false,
    required this.favoriteBuildings,
    this.surname,
    this.dni,
    this.address,
    this.city,
    this.photo,
    this.role = UserRole.user,
    DateTime? creationDateTime,
  }) : createdAt = creationDateTime ?? DateTime.now();

  factory UserModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;
    return UserModel.fromMap(data);
  }

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'username': username,
      'surname': surname,
      'dni': dni,
      'address': address,
      'city': city,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'role': role.name,
      'id': id,
      'photo': photo,
      'stripeCustomerId': stripeCustomerId,
      'emailIsVerified': emailIsVerified,
      'favoriteBuildings': favoriteBuildings,
    };
  }

  Map<String, dynamic> toMap() {
    return toFirestore();
  }

  factory UserModel.fromMap(Map<dynamic, dynamic> map) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      username: map['username'] ?? "",
      surname: map['lastName'],
      emailIsVerified: map['emailIsVerified'],
      dni: map['dni'],
      address: map['address'],
      city: map['city'],
      creationDateTime: DateTime.fromMicrosecondsSinceEpoch(map['createdAt']),
      role: UserRole.fromName(map['role']),
      favoriteBuildings: List.castFrom(map['favoriteBuildings']),
      photo: map['photo'],
      stripeCustomerId: map['stripeCustomerId'],
    );
  }

  void addFav(String buildingId) {
    favoriteBuildings.add(buildingId);
  }

  void removeFav(String buildingId) {
    favoriteBuildings.remove(buildingId);
  }

  UserModel verifyEmail() {
    if (emailIsVerified) return this;
    return UserModel(
      id: id,
      email: email,
      username: username,
      favoriteBuildings: favoriteBuildings,
      emailIsVerified: true,
    );
  }

  bool isFavorite(String buildingId) {
    return favoriteBuildings.contains(buildingId);
  }

  @override
  List<Object?> get props => [
        id,
        email,
        username,
        surname,
        dni,
        address,
        city,
        photo,
        emailIsVerified
      ];
}
