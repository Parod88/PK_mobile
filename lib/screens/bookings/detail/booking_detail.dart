import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:passkey/shared/bloc/bookings/bookings_cubit.dart';
import 'package:passkey/screens/bookings/detail/widgets/detail_header.dart';
import 'package:passkey/screens/bookings/detail/widgets/detail_slider.dart';
import 'package:passkey/screens/bookings/detail/widgets/detail_summary.dart';
import 'package:passkey/screens/bookings/domain/booking_ui_model.dart';
import 'package:passkey/shared/routes/routes.dart';
import 'package:passkey/shared/routes/widgets/section_title.dart';
import 'package:passkey/shared/styles/styles.dart';
import 'package:passkey/shared/theme/icons.dart';
import 'package:passkey/shared/widgets/buttons/small_button.dart';
import 'package:passkey/shared/widgets/screen_layout.dart';
import 'package:passkey/shared/widgets/screens/pop_up.dart';
import 'package:passkey/shared/widgets/screens/sliding_pop_up.dart';
import 'package:passkey/shared/widgets/texts/app_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BookingDetail extends StatelessWidget {
  final BookingUiModel booking;
  const BookingDetail({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final bookingsCubit = BlocProvider.of<BookingsCubit>(context);
    return ScreenLayout(
        pt: 0,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 19, left: 19, top: 65),
                  child: SectionTitle(
                      title: t.bookings_detail_title,
                      icon: AppIcons.leftArrowIcon,
                      secondaryIcon: AppIcons.infoBlueIcon,
                      onSecondaryTap: () => SlidingPopUp(
                          initialSize: 0.902,
                          child: DetailSlider(
                            building: booking.building,
                          )).show(context)),
                ),
                const SizedBox(height: 21),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: BookingDetailHeader(booking: booking),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: BookingDetailSummary(
                    booking: booking,
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 19),
                  child: InkWell(
                    onTap: () => showDialog(
                      context: context,
                      barrierColor: Colors.black.withOpacity(0.60),
                      builder: (BuildContext context) => PopUp(
                        closeBtn: false,
                        hasColor: false,
                        borderRadius: 16,
                        mt: 90,
                        child: SizedBox(
                          height: 138,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: AppText(
                                  text: t.bookings_detail_cancel_message,
                                  align: TextAlign.center,
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: SmallButton(
                                      onTap: () {
                                        bookingsCubit
                                            .cancelBooking(booking.booking);

                                        Navigator.popUntil(
                                          context,
                                          ModalRoute.withName(Routes.layout),
                                        );
                                      },
                                      btnText: t.bookings_detail_cancel_yes_btn,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: SmallButton(
                                      onTap: () => Navigator.pop(context),
                                      btnText: t.bookings_detail_cancel_no_btn,
                                      bgColor: Colors.white,
                                      textColor: darkTextColor,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    child: AppText(
                      text: t.bookings_detail_cancel,
                      color: primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: primaryColor,
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: QrImageView(
                          data:
                              '${dotenv.env['QR_URL']!}?userId=${booking.booking.user.id}&bookingId=${booking.booking.id}',
                          version: QrVersions.auto,
                          size: 290,
                          gapless: false,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
