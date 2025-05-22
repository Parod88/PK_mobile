import 'package:flutter/material.dart';
import 'package:passkey/shared/routes/widgets/section_title.dart';
import 'package:passkey/shared/theme/icons.dart';
import 'package:passkey/shared/widgets/buttons/switch_btn.dart';
import 'package:passkey/shared/widgets/screen_layout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:passkey/shared/widgets/texts/app_text.dart';

class ProfileNotifications extends StatelessWidget {
  const ProfileNotifications({super.key});
  @override
  Widget build(BuildContext context) {
    AppLocalizations t = AppLocalizations.of(context)!;

    return ScreenLayout(
        pt: 65,
        pl: 19,
        pr: 19,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(
                title: t.profile_notifications_title,
                icon: AppIcons.leftArrowIcon),
            const SizedBox(height: 22),
            AppText(text: t.profile_notifications_where),
            const SizedBox(height: 24),
            ProfileSwitch(
              title: t.profile_notifications_push,
            ),
            const SizedBox(height: 24),
            ProfileSwitch(
              title: t.profile_notifications_email,
            ),
          ],
        ));
  }
}

class ProfileSwitch extends StatelessWidget {
  final String title;
  const ProfileSwitch({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          text: title,
          fontWeight: FontWeight.w400,
        ),
        SwitchButton(onTap: () => {}),
      ],
    );
  }
}
