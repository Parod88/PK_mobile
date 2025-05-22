import 'package:flutter/material.dart';
import 'package:passkey/screens/bookings/new-booking/widgets/booking_input.dart';

class BookingDateInput extends StatelessWidget {
  final String icon;
  final String title;
  final String? bottomText;
  final Function onTap;

  const BookingDateInput({
    super.key,
    required this.icon,
    required this.title,
    this.bottomText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BookingInput(
      icon: icon,
      title: title,
      bottomText: bottomText,
      onTap: onTap,
    );
  }
}
