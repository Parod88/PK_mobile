import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passkey/di/injection_container.dart';
import 'package:passkey/screens/auth/bloc/auth_cubit.dart';
import 'package:passkey/screens/profile/widgets/profile_entry.dart';
import 'package:passkey/services/auth_service.dart';
import 'package:passkey/shared/routes/routes.dart';
import 'package:passkey/shared/styles/styles.dart';
import 'package:passkey/shared/theme/icons.dart';
import 'package:passkey/shared/widgets/blue_header.dart';
import 'package:passkey/shared/widgets/screen_layout.dart';
import 'package:passkey/shared/widgets/texts/app_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations t = AppLocalizations.of(context)!;
    final user = getIt<AuthService>().user;
    return ScreenLayout(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlueHeader(
            title: t.profile_title,
            user: user,
          ),
          const SizedBox(height: 40),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 19),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: t.profile_settings_title,
                    size: 16,
                    fontWeight: FontWeight.w600,
                    lineHeight: 1.5,
                    letterSpacing: -0.30,
                    align: TextAlign.center,
                    color: primaryColor,
                  ),
                  const SizedBox(height: 24),
                  ProfileEntry(
                    icon: AppIcons.profileSquaredIcon,
                    text: t.profile_personal_data,
                    route: Routes.profilePersonalData,
                  ),
                  const SizedBox(height: 24),
                  ProfileEntry(
                    icon: AppIcons.shieldCheckIcon,
                    text: t.profile_security,
                    route: Routes.profilePassword,
                  ),
                  const SizedBox(height: 24),
                  ProfileEntry(
                    icon: AppIcons.creditCardIcon,
                    text: t.profile_pay_data_title,
                    route: Routes.profilePaymentData,
                  ),
                  const SizedBox(height: 24),
                  ProfileEntry(
                    icon: AppIcons.bellIcon,
                    text: t.profile_notifications_title,
                    route: Routes.profileNotifications,
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 60),
            padding: const EdgeInsets.symmetric(horizontal: 19),
            child: ProfileEntry(
              onTap: () async {
                try {
                  BlocProvider.of<AuthCubit>(context).logOut();
                } catch (e) {
                  print('Error signing out: $e');
                }
              },
              icon: AppIcons.powerIcon,
              text: t.profile_log_out,
            ),
          ),
        ],
      ),
    );
  }
}
