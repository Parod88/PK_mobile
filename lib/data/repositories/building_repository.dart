import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:passkey/data/repository.dart';
import 'package:passkey/domain/models/building/building.dart';
import 'package:passkey/domain/models/building/building_type.dart';

class BuildingRepository extends Repository<BuildingModel> {
  final CollectionReference _collection = Repository.db.collection('buildings');

  Future<List<BuildingModel>> fetchBuildings(
      [BuildingType? buildingType]) async {
    final querySnapshot = await (buildingType != null
        ? _collection.where("type", isEqualTo: buildingType.name).get()
        : _collection.get());

    return querySnapshot.docs
        .map((doc) => BuildingModel.fromFirestore(doc))
        .toList();
  }

  Future<List<BuildingModel>> getBuildingsById(List<String> ids) async {
    final querySnapshot = await _collection.where("id", whereIn: ids).get();
    return querySnapshot.docs
        .map((doc) => BuildingModel.fromFirestore(doc))
        .toList();
  }

  Future<BuildingModel?> getBuildingById(String id) async {
    final docSnapshot = await _collection.doc(id).get();
    if (docSnapshot.exists) {
      return BuildingModel.fromFirestore(docSnapshot);
    }
    return null;
  }

  Future<void> addBuilding(BuildingModel building) async {
    await _collection.add(building.toFirestore());
  }

  Future<void> updateBuilding(String id, BuildingModel building) async {
    await _collection.doc(id).update(building.toFirestore());
  }

  Future<void> deleteBuilding(String id) async {
    await _collection.doc(id).delete();
  }
}
