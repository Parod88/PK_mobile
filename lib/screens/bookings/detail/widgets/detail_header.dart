import 'package:flutter/material.dart';
import 'package:passkey/screens/bookings/domain/booking_ui_model.dart';
import 'package:passkey/shared/styles/styles.dart';
import 'package:passkey/shared/widgets/texts/app_text.dart';

class BookingDetailHeader extends StatelessWidget {
  const BookingDetailHeader({
    super.key,
    required this.booking,
  });

  final BookingUiModel booking;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(text: booking.building.name),
        const SizedBox(height: 4),
        AppText(
          text: booking.building.address,
          size: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.266,
          color: softTextColor,
        ),
      ],
    );
  }
}
