import 'package:passkey/domain/models/building/apartment.dart';
import 'package:passkey/domain/models/building/building.dart';
import 'package:passkey/domain/models/building/building_type.dart';
import 'package:passkey/domain/models/user/partial_user.dart';
import 'package:passkey/domain/models/user/user.dart';

class PartialBooking {
  final String? start;
  final String? end;
  final int people;
  final List<DateTime> dates;
  final BuildingModel building;
  final PartialUser user;

  const PartialBooking({
    this.start,
    this.end,
    this.people = 0,
    this.dates = const [],
    required this.building,
    required this.user,
  });

  bool get isValid =>
      dates.isNotEmpty && start != null && end != null && people > 0;

  factory PartialBooking.initialize(
    UserModel user,
    BuildingModel building,
  ) {
    if (building.type == BuildingType.apartment) {
      final apartment = building as ApartmentModel;
      return PartialBooking(
        user: PartialUser.initialize(user),
        building: building,
        start: apartment.checkIn,
        end: apartment.checkOut,
      );
    }

    return PartialBooking(
      building: building,
      user: PartialUser.initialize(user),
    );
  }

  PartialBooking copyWith({
    String? start,
    String? end,
    int? people,
    List<DateTime>? dates,
  }) {
    return PartialBooking(
      start: start ?? this.start,
      end: end ?? this.end,
      people: people ?? this.people,
      dates: dates ?? this.dates,
      building: building,
      user: user,
    );
  }

  PartialBooking clean() {
    return PartialBooking(
      people: people,
      building: building,
      user: user,
    );
  }
}
