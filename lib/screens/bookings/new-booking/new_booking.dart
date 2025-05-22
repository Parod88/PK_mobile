import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passkey/di/injection_container.dart';
import 'package:passkey/domain/models/bookings/availability.dart';
import 'package:passkey/screens/bookings/domain/booking_ui_model.dart';
import 'package:passkey/screens/bookings/new-booking/bloc/new_booking_cubit.dart';
import 'package:passkey/screens/bookings/new-booking/bloc/new_booking_state.dart';
import 'package:passkey/screens/bookings/new-booking/domain/partial_booking.dart';
import 'package:passkey/screens/bookings/new-booking/widgets/new_booking_form.dart';
import 'package:passkey/services/auth_service.dart';
import 'package:passkey/shared/routes/routes.dart';
import 'package:passkey/shared/styles/styles.dart';
import 'package:passkey/shared/theme/icons.dart';
import 'package:passkey/shared/theme/images.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:passkey/shared/widgets/header_image_layout.dart';
import 'package:passkey/shared/widgets/texts/app_text.dart';

class NewBooking extends StatefulWidget {
  final Availability availability;

  const NewBooking({
    super.key,
    required this.availability,
  });

  @override
  State<NewBooking> createState() => _NewBookingState();
}

class _NewBookingState extends State<NewBooking> {
  late PartialBooking partialBooking;
  late NewBookingCubit _newBookingCubit;
  late StreamSubscription<NewBookingState> _newBookingStateStreamSubscription;

  @override
  void initState() {
    super.initState();
    final building = widget.availability.building;
    partialBooking = PartialBooking.initialize(
      getIt<AuthService>().user!,
      building,
    );
    _newBookingCubit = BlocProvider.of<NewBookingCubit>(context);
    _newBookingStateStreamSubscription =
        _newBookingCubit.stream.listen((state) {
      if (mounted) {
        if (state is NewBookingSummary) {
          Navigator.pushNamed(
            context,
            Routes.bookingNewSummary,
            arguments: BookingUiModel(
              booking: state.booking,
              building: partialBooking.building,
            ),
          );
        }
      }
    });
  }

  _updatePartialBooking({
    String? start,
    String? end,
    int? people,
    List<DateTime>? dates,
  }) {
    setState(() {
      partialBooking = partialBooking.copyWith(
        start: start,
        end: end,
        people: people,
        dates: dates,
      );
    });
  }

  _clean() {
    setState(() {
      partialBooking = partialBooking.clean();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _newBookingStateStreamSubscription
        .cancel()
        .then((_) => _newBookingCubit.onFormDispose());
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations t = AppLocalizations.of(context)!;

    return ScreenImageLayout(
      height: 260,
      rightIcon: AppIcons.crossCloseIcon,
      rightPadding: 11,
      buttonProps: ButtonProps(
        text: t.bookings_new_main_btn,
        onTap: () => _newBookingCubit.submitForm(partialBooking),
        disabled: !partialBooking.isValid,
      ),
      headerImg: AppImages.mockgym,
      child: Padding(
        padding: const EdgeInsets.only(top: 12, left: 19, right: 19),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: partialBooking.building.name,
              size: 20,
              fontWeight: FontWeight.w600,
              lineHeight: 1.5,
              letterSpacing: -0.38,
            ),
            const SizedBox(height: 4),
            AppText(
              text: partialBooking.building.address,
              color: softTextColor,
              fontWeight: FontWeight.w400,
            ),
            const SizedBox(height: 24),
            NewBookingForm(
              availability: widget.availability,
              updatePartialBooking: _updatePartialBooking,
              clean: _clean,
              partialBooking: partialBooking,
            ),
          ],
        ),
      ),
    );
  }
}
