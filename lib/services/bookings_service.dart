import 'package:passkey/data/repositories/bookings_repository.dart';
import 'package:passkey/data/repositories/building_repository.dart';
import 'package:passkey/domain/models/bookings/booking_model.dart';
import 'package:passkey/domain/models/bookings/booking_status.dart';
import 'package:passkey/screens/bookings/domain/booking_ui_model.dart';

class BookingService {
  final BookingRepository _bookingRepository;
  final BuildingRepository _buildingRepository;

  const BookingService(
    this._bookingRepository,
    this._buildingRepository,
  );

  Future<void> cancelBooking(BookingModel booking) async {
    await _bookingRepository.updateBooking(
      booking.copyWith(status: BookingStatus.cancelled),
    );
  }

  Future<List<BookingUiModel>> fetchUserBookings(String userId) async {
    final bookings = await _bookingRepository.fetchUserBookings(userId);

    final buildingIds = bookings.map((booking) => booking.building.id).toList();
    if (buildingIds.isEmpty) return [];
    final buildings = await _buildingRepository.getBuildingsById(buildingIds);

    return bookings.map((booking) {
      final building = buildings.firstWhere(
        (b) => b.id == booking.building.id,
      );
      return BookingUiModel(
        booking: booking,
        building: building,
      );
    }).toList();
  }

  Future<List<BookingModel>> fetchBuildingBookings(String buildingId) async {
    final bookings = await _bookingRepository.fetchBookings(buildingId);

    return bookings;
  }

  Future<void> saveBooking(BookingModel booking) async {
    await _bookingRepository.addBooking(booking);
  }
}
