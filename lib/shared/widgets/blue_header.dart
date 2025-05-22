import 'package:flutter/material.dart';
import 'package:passkey/domain/models/user/user.dart';
import 'package:passkey/shared/styles/styles.dart';
import 'package:passkey/shared/theme/icons.dart';
import 'package:passkey/shared/utils/strings.dart';
import 'package:passkey/shared/widgets/circled_img.dart';
import 'package:passkey/shared/widgets/texts/app_text.dart';

class BlueHeader extends StatelessWidget {
  final String title;
  final UserModel? user;
  final double? height;

  const BlueHeader({
    super.key,
    required this.title,
    this.user,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    bool isProfileScreen = user != null;

    return Container(
      padding: const EdgeInsets.only(top: 76, right: 19, left: 19),
      color: primaryColor,
      height: height ?? 172 + MediaQuery.of(context).padding.top,
      child: Row(
        mainAxisAlignment: isProfileScreen
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(
                text: title,
                color: Colors.white,
                size: 16,
                fontWeight: FontWeight.w700,
                lineHeight: 1.5,
                letterSpacing: -0.30,
              ),
              const SizedBox(height: 16),
              if (isProfileScreen)
                AppText(
                  text: '${user!.username} ${user?.surname ?? ""}'
                      .capitalizeAll(),
                  color: Colors.white,
                  size: 16,
                  fontWeight: FontWeight.w600,
                  lineHeight: 1.5,
                  letterSpacing: -0.30,
                ),
            ],
          ),
          if (isProfileScreen)
            CircledImage(
              icon: user?.photo ?? AppIcons.profileIcon,
              diameter: 52,
            ),
        ],
      ),
    );
  }
}
