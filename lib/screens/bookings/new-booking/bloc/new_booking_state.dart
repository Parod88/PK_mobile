import 'package:equatable/equatable.dart';
import 'package:passkey/domain/models/bookings/availability.dart';
import 'package:passkey/domain/models/bookings/booking_model.dart';
import 'package:passkey/domain/models/building/building.dart';

abstract class NewBookingState extends Equatable {
  const NewBookingState();
}

class NewBookingInitial extends NewBookingState {
  const NewBookingInitial();
  @override
  List<Object> get props => [];
}

class NewBookingStartProcess extends NewBookingState {
  final BuildingModel building;
  const NewBookingStartProcess({required this.building});
  @override
  List<Object> get props => [building];
}

class NewBookingFetchPrevBookings extends NewBookingState {
  const NewBookingFetchPrevBookings();
  @override
  List<Object> get props => [];
}

class NewBookingSaveBooking extends NewBookingState {
  const NewBookingSaveBooking();
  @override
  List<Object> get props => [];
}

class NewBookingFormState extends NewBookingState {
  final Availability availability;
  const NewBookingFormState({
    required this.availability,
  });
  @override
  List<Object> get props => [availability];
}

class NewBookingSummary extends NewBookingState {
  final BookingModel booking;
  const NewBookingSummary({required this.booking});
  @override
  List<Object> get props => [booking];
}

class NewBookingSuccess extends NewBookingState {
  final BookingModel booking;
  const NewBookingSuccess({required this.booking});
  @override
  List<Object> get props => [booking];
}

class NewBookingError extends NewBookingState {
  const NewBookingError();
  @override
  List<Object> get props => [];
}
