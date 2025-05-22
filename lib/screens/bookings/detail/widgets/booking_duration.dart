import 'package:flutter/material.dart';
import 'package:passkey/domain/models/bookings/booking_model.dart';
import 'package:passkey/shared/styles/styles.dart';
import 'package:passkey/shared/utils/dates.dart';
import 'package:passkey/shared/widgets/texts/app_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookingDuration extends StatelessWidget {
  final BookingModel bookingModel;
  const BookingDuration({super.key, required this.bookingModel});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return bookingModel.building.buildingType.isGym
        ? AppText(
            text: DateFormatter.formatMinutesToLocalizedHoursAndMinutes(
              t,
              bookingModel.bookingTime.duration.inMinutes,
            ),
            size: 14,
            letterSpacing: -0.266,
            color: softTextColor,
          )
        : AppText(
            text: '${bookingModel.dates.length} ${t.days}',
            size: 14,
            letterSpacing: -0.266,
            color: softTextColor,
          );
  }
}
