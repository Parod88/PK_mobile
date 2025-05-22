import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Repository<T> {
  static final db = FirebaseFirestore.instance;
}
