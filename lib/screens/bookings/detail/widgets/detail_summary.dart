import 'package:flutter/material.dart';
import 'package:passkey/domain/models/bookings/booking_model.dart';
import 'package:passkey/screens/bookings/detail/widgets/booking_duration.dart';
import 'package:passkey/screens/bookings/domain/booking_ui_model.dart';
import 'package:passkey/shared/styles/styles.dart';
import 'package:passkey/shared/utils/dates.dart';
import 'package:passkey/shared/utils/money.dart';
import 'package:passkey/shared/widgets/texts/app_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookingDetailSummary extends StatelessWidget {
  final BookingUiModel booking;
  final bool hidePrice;
  final double space;
  const BookingDetailSummary({
    super.key,
    required this.booking,
    this.hidePrice = false,
    this.space = 4,
  });

  @override
  Widget build(BuildContext context) {
    BookingModel book = booking.booking;
    final t = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(text: t.bookings_detail_summary),
        SummarySection(
          title: t.bookings_detail_date,
          text: book.dates.length > 1
              ? '${DateFormatter.formatLocalizedDate(
                  t,
                  book.dates.first,
                )} - ${DateFormatter.formatLocalizedDate(
                  t,
                  book.dates.last,
                )}'
              : DateFormatter.formatLocalizedDate(t, book.dates.first),
        ),
        SizedBox(
          height: space,
        ),
        SummarySection(
          title: t.bookings_detail_people,
          text:
              '${book.peopleNumber} ${t.bookings_detail_number_people(book.peopleNumber)}',
        ),
        SizedBox(
          height: space,
        ),
        SummarySection(
          title: t.bookings_detail_time,
          text: '${book.bookingTime.start} - ${book.bookingTime.end}',
        ),
        !hidePrice
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: space,
                  ),
                  SummarySection(
                    title: t.bookings_detail_price,
                    text: '${book.price.ui}€',
                  ),
                  BookingDuration(
                    bookingModel: booking.booking,
                  ),
                ],
              )
            : Container()
      ],
    );
  }
}

class SummarySection extends StatelessWidget {
  final String title;
  final String text;
  const SummarySection({
    super.key,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: title,
          size: 14,
          letterSpacing: -0.266,
        ),
        const SizedBox(height: 4),
        AppText(
          text: text,
          size: 14,
          letterSpacing: -0.266,
          color: softTextColor,
        ),
      ],
    );
  }
}
