import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passkey/domain/models/bookings/booking_model.dart';
import 'package:passkey/domain/models/bookings/booking_status.dart';
import 'package:passkey/shared/bloc/bookings/bookings_state.dart';
import 'package:passkey/services/bookings_service.dart';

class BookingsCubit extends Cubit<BookingsState> {
  final BookingService _bookingService;

  BookingsCubit(
    this._bookingService,
  ) : super(BookingsInitial());

  void fetchBookings(String userId) async {
    emit(BookingsLoading());
    final bookings = (await _bookingService.fetchUserBookings(userId)).where(
        (booking) => [
              BookingStatus.confirmed,
              BookingStatus.pending,
              BookingStatus.resolved
            ].contains(booking.booking.status));
    final current =
        bookings.where((booking) => booking.booking.hasNotStarted).toList();

    final historical =
        bookings.where((booking) => booking.booking.hasFinished).toList();

    emit(BookingsSuccess(current: current, historical: historical));
  }

  void cancelBooking(BookingModel booking) async {
    emit(BookingsLoading());
    await _bookingService.cancelBooking(
      booking,
    );

    emit(BookingsRefetch());
  }
}
