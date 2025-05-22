import 'package:flutter/material.dart';
import 'package:passkey/domain/models/building/building.dart';
import 'package:passkey/domain/models/building/building_type.dart';
import 'package:passkey/screens/auth/sign-in/sign_in.dart';
import 'package:passkey/screens/auth/sign-up/sign_up.dart';
import 'package:passkey/screens/buildings/building_detail.dart';
import 'package:passkey/screens/forgot_password.dart';
import 'package:passkey/screens/layout.dart';
import 'package:passkey/screens/onboarding/onboarding.dart';
import 'package:passkey/shared/guards/auth_guard.dart';
import 'package:passkey/shared/routes/routes.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {
  Routes.signIn: (context) => const AuthGuard(child: SignIn()),
  Routes.signUp: (context) => const AuthGuard(child: SignUp()),
  Routes.layout: (context) => AuthGuard(
          child: Layout(
        modality: ModalRoute.of(context)!.settings.arguments! as BuildingType,
      )),
  Routes.forgotPassword: (context) => const AuthGuard(child: ForgotPassword()),
  Routes.onboarding: (context) => const AuthGuard(child: Onboarding()),
  Routes.buildingDetails: (context) => BuildingDetail(
        building: ModalRoute.of(context)!.settings.arguments as BuildingModel,
      ),
};
