import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:passkey/domain/models/bookings/booking_time.dart';
import 'package:passkey/domain/models/building/building.dart';
import 'package:passkey/domain/models/building/building_type.dart';
import 'package:passkey/domain/models/building/schedule.dart';

class ApartmentModel extends BuildingModel {
  ApartmentModel({
    required super.rules,
    required super.cancelPolitics,
    required super.id,
    required super.name,
    required super.images,
    required super.address,
    required super.description,
    required super.status,
    required super.features,
    required super.schedule,
    required super.maxCapacity,
    required super.pricePerUnit,
  }) : super(
          type: BuildingType.apartment,
        );

  @override
  double totalPrice(List<DateTime> dates, BookingTime bookingTime) {
    return pricePerUnit * dates.length - 1;
  }

  String get checkIn => schedule.entries.first.value.first.open;
  String get checkOut => schedule.entries.first.value.first.close;

  factory ApartmentModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return ApartmentModel(
      id: doc.id,
      name: data['name'],
      address: data['address'],
      description: data['description'],
      images: List<String>.from(data['images']),
      maxCapacity: data['maxCapacity'],
      features: List<String>.from(data['features']),
      status: BuildingStatus.fromName(data['status']),
      schedule: Schedule.fromFirestore(doc),
      rules: data['rules'],
      cancelPolitics: data['cancelPolitics'],
      pricePerUnit: (data['pricePerUnit'] as int).toDouble(),
    );
  }
}
