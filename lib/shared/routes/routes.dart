import 'package:flutter/material.dart';
import 'package:passkey/domain/models/bookings/availability.dart';
import 'package:passkey/domain/models/building/building.dart';
import 'package:passkey/screens/bookings/detail/booking_detail.dart';
import 'package:passkey/screens/bookings/domain/booking_ui_model.dart';
import 'package:passkey/screens/bookings/new-booking/new_booking_summary.dart';
import 'package:passkey/screens/bookings/new-booking/new_booking.dart';
import 'package:passkey/screens/buildings/building_detail.dart';
import 'package:passkey/screens/profile/credit-card/add_credit_card.dart';
import 'package:passkey/screens/profile/profile-notifications/profile_notifications.dart';
import 'package:passkey/screens/profile/profile-password/profile_password.dart';
import 'package:passkey/screens/profile/profile-payment-data/profile_payment_data.dart';
import 'package:passkey/screens/profile/profile-personal-data/profile_personal_data.dart';
import 'package:passkey/shared/routes/widgets/navigate_to.dart';

class Routes {
  Routes._();

  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String layout = '/layout';

  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String forgotPassword = '/forgot-password';
  static const String recovery = '/recovery';

  static const String buildingDetails = '/building-detail';

  //Profile
  static const String profilePassword = '/profile/password';
  static const String profilePersonalData = '/profile/personal-data';
  static const String profilePaymentData = '/profile/paying-data';
  static const String profileAddCard = '/profile/add-card';
  static const String profileNotifications = '/profile/notifications';

  static const String bookingNew = '/booking/new';
  static const String bookingNewSummary = '/booking/new/summary';
  static const String bookingDetail = '/booking/detail';
}

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.buildingDetails:
      return NavigateToRoute(
        widget: BuildingDetail(building: settings.arguments as BuildingModel),
      );
    //Profile routes
    case Routes.profilePassword:
      return NavigateToRoute(widget: const ProfilePassword());
    case Routes.profilePersonalData:
      return NavigateToRoute(widget: const ProfilePersonalData());
    case Routes.profilePaymentData:
      return NavigateToRoute(widget: const ProfilePaymentData());
    case Routes.profileAddCard:
      return NavigateToRoute(widget: const AddCreditCard());
    case Routes.profileNotifications:
      return NavigateToRoute(widget: const ProfileNotifications());
    //Booking routes
    case Routes.bookingNew:
      final args = settings.arguments as Availability;

      return NavigateToRoute(
        widget: NewBooking(
          availability: args,
        ),
      );
    case Routes.bookingNewSummary:
      final args = settings.arguments as BookingUiModel;
      return NavigateToRoute(
        widget: NewBookingSummary(
          booking: args,
        ),
      );
    case Routes.bookingDetail:
      final args = settings.arguments as BookingUiModel;
      return NavigateToRoute(
        widget: BookingDetail(
          booking: args,
        ),
      );
  }
  return null;
}
