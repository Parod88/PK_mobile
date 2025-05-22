import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passkey/screens/bookings/widgets/booking_card.dart';
import 'package:passkey/screens/bookings/widgets/toggle_bookings.dart';
import 'package:passkey/di/injection_container.dart';
import 'package:passkey/services/auth_service.dart';
import 'package:passkey/shared/bloc/bookings/bookings_cubit.dart';
import 'package:passkey/shared/bloc/bookings/bookings_state.dart';
import 'package:passkey/shared/routes/routes.dart';
import 'package:passkey/shared/styles/styles.dart';
import 'package:passkey/shared/widgets/blue_header.dart';
import 'package:passkey/shared/widgets/screen_layout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum BookingScreenMode { current, history }

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  BookingScreenState createState() => BookingScreenState();
}

class BookingScreenState extends State<BookingScreen> {
  BookingScreenMode mode = BookingScreenMode.current;
  late BookingsCubit _bookingsCubit;
  final userId = getIt<AuthService>().user!.id;
  @override
  void initState() {
    super.initState();
    _bookingsCubit = BlocProvider.of<BookingsCubit>(context);
    _bookingsCubit.fetchBookings(userId);
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations t = AppLocalizations.of(context)!;

    return ScreenLayout(
      child: Column(
        children: [
          BlueHeader(
            title: t.bookings_title,
            height: 124,
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19),
            child: Column(
              children: [
                ToggleBookings(
                  onToggle: (BookingScreenMode nextMode) => setState(() {
                    mode = nextMode;
                  }),
                  tab1Title: t.bookings_toggle_title_first,
                  tab2Title: t.bookings_toggle_title_second,
                ),
                const SizedBox(height: 13),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 19),
              child: BlocConsumer<BookingsCubit, BookingsState>(
                  listener: (_, state) {
                if (state is BookingsRefetch) {
                  _bookingsCubit.fetchBookings(userId);
                }
              }, builder: (context, state) {
                if (state is BookingsLoading) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: primaryColor,
                  ));
                }
                if (state is BookingsSuccess) {
                  final bookings = mode == BookingScreenMode.current
                      ? state.current
                      : state.historical;
                  return MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: bookings.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: BookingMainCard(
                            booking: bookings[index],
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Routes.bookingDetail,
                                arguments: bookings[index],
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                }
                return Container();
              }),
            ),
          ),
        ],
      ),
    );
  }
}
