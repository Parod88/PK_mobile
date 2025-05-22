import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passkey/di/injection_container.dart';
import 'package:passkey/screens/bookings/detail/widgets/booking_duration.dart';
import 'package:passkey/screens/bookings/detail/widgets/detail_summary.dart';
import 'package:passkey/screens/bookings/domain/booking_ui_model.dart';
import 'package:passkey/screens/bookings/new-booking/bloc/new_booking_cubit.dart';
import 'package:passkey/screens/bookings/new-booking/bloc/new_booking_state.dart';
import 'package:passkey/services/auth_service.dart';
import 'package:passkey/shared/app_divider.dart';
import 'package:passkey/shared/bloc/bookings/bookings_cubit.dart';
import 'package:passkey/shared/bloc/user/user_cubit.dart';
import 'package:passkey/shared/mixin/floating_toast.dart';
import 'package:passkey/shared/mixin/loading.dart';
import 'package:passkey/shared/routes/routes.dart';
import 'package:passkey/shared/styles/styles.dart';
import 'package:passkey/shared/theme/icons.dart';
import 'package:passkey/shared/theme/images.dart';
import 'package:passkey/shared/utils/dates.dart';
import 'package:passkey/shared/utils/money.dart';
import 'package:passkey/shared/widgets/header_image_layout.dart';
import 'package:passkey/shared/widgets/texts/app_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewBookingSummary extends StatefulWidget {
  final BookingUiModel booking;
  const NewBookingSummary({
    super.key,
    required this.booking,
  });

  @override
  State<NewBookingSummary> createState() => _NewBookingSummaryState();
}

class _NewBookingSummaryState extends State<NewBookingSummary>
    with LoadingOverlay, FloatingToast {
  late NewBookingCubit _newBookingCubit;
  late StreamSubscription<NewBookingState> _newBookingStateStreamSubscription;
  @override
  void initState() {
    super.initState();
    _newBookingCubit = BlocProvider.of<NewBookingCubit>(context);

    _newBookingStateStreamSubscription =
        _newBookingCubit.stream.listen((state) {
      if (mounted) {
        if (state is NewBookingSaveBooking) {
          showSpinner(context);
        }
        if (state is NewBookingError) {
          hideSpinner();
        }
        if (state is NewBookingSuccess) {
          hideSpinner();
          BlocProvider.of<UserCubit>(context).getUser();
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.bookingDetail,
            ModalRoute.withName(Routes.layout),
            arguments: widget.booking,
          );
          BlocProvider.of<BookingsCubit>(context)
              .fetchBookings(state.booking.user.id);
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _newBookingStateStreamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations t = AppLocalizations.of(context)!;
    final booking = widget.booking.booking;
    final building = widget.booking.building;

    return ScreenImageLayout(
      height: 260,
      rightIcon: AppIcons.crossCloseIcon,
      rightPadding: 11,
      headerImg: AppImages.mockgym,
      rightOnTap: () {
        _newBookingStateStreamSubscription
            .cancel()
            .then((_) => _newBookingCubit.onFormDispose());
        Navigator.popUntil(
          context,
          ModalRoute.withName(Routes.layout),
        );
      },
      buttonProps: ButtonProps(
        text: t.bookings_new_summary_main_btn,
        onTap: () => _newBookingCubit.saveBooking(
          booking,
          getIt<AuthService>().user!,
        ),
        disabled: false,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 12, right: 19, left: 19),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: building.name,
                  lineHeight: 1.5,
                  letterSpacing: -0.38,
                ),
                AppText(
                  text: building.address,
                  size: 14,
                  lineHeight: 1.5,
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.266,
                  color: softTextColor,
                ),
                const SizedBox(height: 16),
                BookingDetailSummary(
                  hidePrice: true,
                  space: 12,
                  booking: BookingUiModel(
                    booking: booking,
                    building: building,
                  ),
                ),
                const SizedBox(height: 12),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: AppText(
                    text: t.bookings_new_summary_edit,
                    color: primaryColor,
                  ),
                ),
                const AppDivider(mt: 12, mb: 12),
                AppText(
                  text: t.bookings_detail_price,
                  lineHeight: 1.5,
                  letterSpacing: -0.38,
                ),
                const SizedBox(height: 4),
                AppText(
                  text: '${booking.price.ui}€',
                  lineHeight: 1.5,
                  letterSpacing: -0.38,
                ),
                const SizedBox(height: 4),
                AppText(
                  text: booking.dates.length > 1
                      ? '${DateFormatter.onlyDate(
                          booking.dates.first,
                        )} - ${DateFormatter.onlyDate(
                          booking.dates.last,
                        )}'
                      : DateFormatter.formatLocalizedDate(
                          t, booking.dates.first),
                  size: 14,
                  color: softTextColor,
                ),
                const SizedBox(height: 4),
                BookingDuration(
                  bookingModel: booking,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
