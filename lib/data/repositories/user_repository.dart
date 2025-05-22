import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:passkey/data/repository.dart';
import 'package:passkey/domain/models/user/user.dart';

class UserRepository extends Repository<UserModel> {
  final CollectionReference<Map<String, dynamic>> _collection =
      Repository.db.collection('users');

  Future<UserModel?> getUser(String id) async {
    final docSnapshot = await _collection.doc(id).get();

    return UserModel.fromFirestore(docSnapshot);
  }

  Future<UserModel?> queryByEmail(String email) async {
    final querySnapshot = await _collection
        .where('email', isEqualTo: email.toLowerCase())
        .limit(1)
        .get();

    return querySnapshot.docs.isNotEmpty
        ? UserModel.fromFirestore(querySnapshot.docs[0])
        : null;
  }

  Future<void> addUser(UserModel user) async {
    await _collection.doc(user.id).set(user.toFirestore());
  }

  Future<bool> checkUserExist(String email) async {
    final result =
        await _collection.where('email', isEqualTo: email).limit(1).get();

    return result.docs.isNotEmpty;
  }

  Future<void> updateUser(UserModel user) async {
    await _collection.doc(user.id).update(user.toFirestore());
  }
}
