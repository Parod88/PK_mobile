import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:passkey/domain/models/bookings/booking_time.dart';
import 'package:passkey/domain/models/building/apartment.dart';
import 'package:passkey/domain/models/building/building_type.dart';
import 'package:passkey/domain/models/building/gym.dart';
import 'package:passkey/domain/models/building/opening.dart';
import 'package:passkey/domain/models/building/schedule.dart';

enum BuildingStatus {
  open,
  closed;

  factory BuildingStatus.fromName(String name) {
    switch (name) {
      case 'open':
        return BuildingStatus.open;
      case 'closed':
        return BuildingStatus.closed;
      default:
        throw Exception('Invalid status name');
    }
  }
}

abstract class BuildingModel {
  final String id;
  final String name;
  final List<String> images;
  final String address;
  final String description;
  final BuildingType type;
  final BuildingStatus status;
  final List<String> features;
  final Map<WeekDay, List<Opening>> schedule;
  final int maxCapacity;
  final double pricePerUnit;
  final String rules;
  final String cancelPolitics;

  BuildingModel({
    required this.id,
    required this.name,
    required this.images,
    required this.address,
    required this.description,
    required this.type,
    required this.status,
    required this.features,
    required this.schedule,
    required this.maxCapacity,
    required this.pricePerUnit,
    required this.rules,
    required this.cancelPolitics,
  });

  double totalPrice(List<DateTime> dates, BookingTime bookingTime);

  factory BuildingModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    if (BuildingType.fromName(data['type']) == BuildingType.gym) {
      return GymModel.fromFirestore(doc);
    }

    return ApartmentModel.fromFirestore(doc);
  }

  Map<String, dynamic> toFirestore() {
    Map<String, dynamic> scheduleJSON = {};
    for (var k in schedule.entries) {
      scheduleJSON.putIfAbsent(
          k.key.name, () => k.value.map((opening) => opening.toMap()));
    }

    return {
      'name': name,
      'address': address,
      'description': description,
      'type': type.index,
      'images': images,
      'features': features,
      'status': status.index,
      'maxCapacity': maxCapacity,
      'pricePerUnit': pricePerUnit,
      'schedule': scheduleJSON,
    };
  }
}
