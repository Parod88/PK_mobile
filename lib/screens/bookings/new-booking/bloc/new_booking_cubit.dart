import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passkey/data/repositories/bookings_repository.dart';
import 'package:passkey/di/injection_container.dart';
import 'package:passkey/domain/models/bookings/availability.dart';
import 'package:passkey/domain/models/bookings/booking_model.dart';
import 'package:passkey/domain/models/bookings/booking_status.dart';
import 'package:passkey/domain/models/bookings/booking_time.dart';
import 'package:passkey/domain/models/building/building.dart';
import 'package:passkey/domain/models/building/partial_building.dart';
import 'package:passkey/domain/models/payments/payment.dart';
import 'package:passkey/domain/models/user/user.dart';
import 'package:passkey/screens/bookings/new-booking/bloc/new_booking_state.dart';
import 'package:passkey/screens/bookings/new-booking/domain/partial_booking.dart';
import 'package:passkey/services/bookings_service.dart';
import 'package:passkey/services/stripe_service.dart';

class NewBookingCubit extends Cubit<NewBookingState> {
  final BookingService _bookingService;
  NewBookingCubit(this._bookingService) : super(const NewBookingInitial());

  void selectBuilding(BuildingModel building) {
    emit(NewBookingStartProcess(building: building));
  }

  void fetchPrevBookings(BuildingModel building) async {
    emit(const NewBookingFetchPrevBookings());

    final List<BookingModel> bookings =
        await _bookingService.fetchBuildingBookings(building.id);

    emit(
      NewBookingFormState(
        availability: Availability(building: building, bookings: bookings),
      ),
    );
  }

  void submitForm(PartialBooking partialBooking) async {
    if (!partialBooking.isValid) return;
    final bookingTime = BookingTime(
      start: partialBooking.start!,
      end: partialBooking.end!,
    );

    final booking = BookingModel(
      id: getIt<BookingRepository>().generateId(),
      user: partialBooking.user,
      building: PartialBuilding.initialize(partialBooking.building),
      bookingTime: bookingTime,
      dates: partialBooking.dates
          .map((date) => bookingTime.toDate(date).first)
          .toList(),
      status: BookingStatus.pending,
      price:
          partialBooking.building.totalPrice(partialBooking.dates, bookingTime),
      peopleNumber: partialBooking.people,
    );

    emit(
      NewBookingSummary(
        booking: booking,
      ),
    );
  }

  void onFormDispose() {
    emit(const NewBookingInitial());
  }

  void saveBooking(BookingModel booking, UserModel user) async {
    emit(const NewBookingSaveBooking());

    await _bookingService.saveBooking(booking);

    final bool success = await StripeService.makePayment(
      user: user,
      payment: Payment(
        amount: booking.price,
        bookingId: booking.id,
        userId: booking.user.id,
      ),
    );

    if (success) {
      emit(NewBookingSuccess(booking: booking));
    } else {
      await _bookingService.cancelBooking(booking);
      emit(
        const NewBookingError(),
      );
    }
  }
}
