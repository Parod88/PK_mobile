import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:passkey/domain/models/bookings/booking_status.dart';
import 'package:passkey/domain/models/bookings/booking_time.dart';
import 'package:passkey/domain/models/bookings/booking_type.dart';
import 'package:passkey/domain/models/building/partial_building.dart';
import 'package:passkey/domain/models/user/partial_user.dart';

class BookingModel {
  final String id;
  final PartialUser user;
  final PartialBuilding building;
  final List<DateTime> dates;
  final BookingTime bookingTime;
  final BookingStatus status;
  final double price;
  final int peopleNumber;

  BookingModel({
    required this.id,
    required this.user,
    required this.building,
    required this.bookingTime,
    required this.dates,
    required this.status,
    required this.price,
    required this.peopleNumber,
  });

  DateTime get startDate {
    dates.sort((a, b) => a.compareTo(b));
    return bookingTime.toDate(dates.first).first;
  }

  DateTime get endDate {
    dates.sort((a, b) => a.compareTo(b));
    return bookingTime.toDate(dates.last).last;
  }

  bool get hasFinished {
    final byTime = DateTime.now().isAfter(endDate);
    return byTime;
  }

  bool get hasNotStarted {
    final byTime = DateTime.now().isBefore(startDate);
    return byTime;
  }

  factory BookingModel.fromFirestore(
    DocumentSnapshot doc,
  ) {
    final data = doc.data() as Map<String, dynamic>;
    return BookingModel(
      id: data['id'],
      user: PartialUser.fromMap(data['user']),
      building: PartialBuilding.fromMap(data['building']),
      bookingTime: BookingTime.fromMap(data['bookingTime']),
      status: BookingStatus.fromValue(data['status']),
      dates: List.castFrom(data['dates'])
          .map((date) => DateTime.fromMillisecondsSinceEpoch(date, isUtc: true))
          .toList(),
      price: data['price'],
      peopleNumber: data['peopleNumber'],
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'user': user.toMap(),
      'building': building.toMap(),
      'bookingTime': bookingTime.toMap(),
      'dates': dates.map((date) => date.millisecondsSinceEpoch).toList(),
      'status': status.name,
      'price': price,
      'peopleNumber': peopleNumber,
    };
  }

  BookingModel copyWith({
    String? id,
    PartialUser? user,
    PartialBuilding? building,
    List<DateTime>? dates,
    BookingTime? bookingTime,
    BookingStatus? status,
    double? price,
    int? peopleNumber,
    BookingType? bookingType,
  }) {
    return BookingModel(
      id: id ?? this.id,
      user: user ?? this.user,
      dates: dates ?? this.dates,
      building: building ?? this.building,
      bookingTime: bookingTime ?? this.bookingTime,
      status: status ?? this.status,
      price: price ?? this.price,
      peopleNumber: peopleNumber ?? this.peopleNumber,
    );
  }
}
