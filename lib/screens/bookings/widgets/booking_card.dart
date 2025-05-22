import 'package:flutter/material.dart';
import 'package:passkey/screens/bookings/domain/booking_ui_model.dart';
import 'package:passkey/shared/widgets/cards/main_card.dart';

class BookingMainCard extends StatelessWidget {
  final BookingUiModel booking;
  final Function onTap;

  const BookingMainCard(
      {super.key, required this.booking, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return MainCard(
      building: booking.building,
      booking: booking.booking,
      height: 254,
      onTap: onTap,
    );
  }
}
