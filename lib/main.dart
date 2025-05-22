import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:passkey/di/injection_container.dart';
import 'package:passkey/l10n/l10n.dart';
import 'package:passkey/screens/auth/bloc/auth_cubit.dart';
import 'package:passkey/screens/bookings/new-booking/bloc/new_booking_cubit.dart';
import 'package:passkey/screens/profile/profile-payment-data/bloc/payment_data_cubit.dart';
import 'package:passkey/shared/bloc/bookings/bookings_cubit.dart';
import 'package:passkey/services/auth_service.dart';
import 'package:passkey/services/local_storage.dart';
import 'package:passkey/services/push_notification.dart';
import 'package:passkey/shared/bloc/user/user_cubit.dart';
import 'package:passkey/shared/routes/app_routes.dart';
import 'package:passkey/shared/routes/routes.dart';
import 'package:passkey/shared/bloc/buildings/buildings_cubit.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PushNotificationService.initializeApp();

  await LocalStorage().init();

  await initDependencies();

  await dotenv.load(fileName: "assets/.env");
  Stripe.publishableKey = dotenv.env['STRIPE_PUBLIC_KEY']!;
  await getIt<AuthService>().loadSession();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => BookingsCubit(getIt())),
        BlocProvider(create: (_) => BuildingsCubit(getIt())),
        BlocProvider(create: (_) => UserCubit(getIt())),
        BlocProvider(create: (_) => AuthCubit(getIt())),
        BlocProvider(create: (_) => NewBookingCubit(getIt())),
        BlocProvider(create: (_) => AuthCubit(getIt())),
        BlocProvider(create: (_) => PaymentDataCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: const Locale('en'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: L10n.all,
        builder: (context, widget) => GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: widget,
        ),
        routes: appRoutes,
        initialRoute: getIt<AuthService>().user == null
            ? Routes.signIn
            : Routes.onboarding,
        onGenerateRoute: generateRoute,
        theme: ThemeData(
          fontFamily: 'OpenSans',
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
      ),
    );
  }
}
