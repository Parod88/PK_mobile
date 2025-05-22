import 'package:passkey/domain/models/building/building.dart';
import 'package:passkey/domain/models/building/building_type.dart';

class PartialBuilding {
  final String id;
  final String name;
  final String address;
  final BuildingType buildingType;

  PartialBuilding({
    required this.address,
    required this.id,
    required this.buildingType,
    required this.name,
  });

  factory PartialBuilding.initialize(BuildingModel building) {
    return PartialBuilding(
      address: building.address,
      id: building.id,
      buildingType: building.type,
      name: building.name,
    );
  }

  factory PartialBuilding.fromMap(Map<String, dynamic> map) {
    return PartialBuilding(
      id: map['id'],
      name: map['name'],
      address: map['address'],
      buildingType: BuildingType.fromName(map['buildingType']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'buildingType': buildingType.name,
    };
  }
}
