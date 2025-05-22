import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:passkey/domain/models/building/building_type.dart';
import 'package:passkey/screens/onboarding/widgets/modality-button.dart';
import 'package:passkey/shared/routes/routes.dart';
import 'package:passkey/shared/styles/styles.dart';
import 'package:passkey/shared/theme/icons.dart';
import 'package:passkey/shared/theme/images.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:passkey/shared/utils/strings.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations t = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(top: 130),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.zero,
          image: DecorationImage(
            image: AssetImage(AppImages.onboardingImg),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(AppIcons.keyIcon),
            const SizedBox(height: 10),
            Text(
              t.on_boarding_title.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w700,
                fontFamily: 'OpenSans',
                height: 1.5,
                letterSpacing: -0.608,
              ),
            ),
            const SizedBox(height: 50),
            InkWell(
              splashColor: Colors.transparent,
              onTap: () => Navigator.pushNamed(
                context,
                Routes.layout,
                arguments: BuildingType.gym,
              ),
              child: CheckModality(
                name: t.on_boarding_gym_btn.capitalize(),
                isFlat: true,
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
                splashColor: Colors.transparent,
                onTap: () => Navigator.pushNamed(
                      context,
                      Routes.layout,
                      arguments: BuildingType.apartment,
                    ),
                child:
                    CheckModality(name: t.on_boarding_hostel_btn.capitalize()))
          ],
        ),
      ),
    );
  }
}
