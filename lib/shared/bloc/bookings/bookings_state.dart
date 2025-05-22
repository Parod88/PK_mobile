import 'package:equatable/equatable.dart';
import 'package:passkey/screens/bookings/domain/booking_ui_model.dart';

abstract class BookingsState extends Equatable {
  const BookingsState();
}

class BookingsInitial extends BookingsState {
  @override
  List<Object> get props => [];
}

class BookingsLoading extends BookingsState {
  @override
  List<Object> get props => [];
}

class BookingsRefetch extends BookingsState {
  @override
  List<Object> get props => [];
}

class BookingsSuccess extends BookingsState {
  final List<BookingUiModel> current;
  final List<BookingUiModel> historical;
  const BookingsSuccess({
    required this.current,
    required this.historical,
  });

  @override
  List<Object?> get props => [current, historical];
}

class BookingsError extends BookingsState {
  final String message;
  const BookingsError({required this.message});

  @override
  List<Object?> get props => [message];
}
