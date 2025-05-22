import 'package:passkey/domain/models/bookings/booking_model.dart';
import 'package:passkey/domain/models/building/building.dart';

class BookingUiModel {
  final BookingModel booking;
  final BuildingModel building;

  const BookingUiModel({
    required this.booking,
    required this.building,
  });
}
