import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passkey/shared/widgets/texts/app_text.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String icon;
  final String? secondaryIcon;
  final Function()? onSecondaryTap;

  const SectionTitle({
    super.key,
    required this.title,
    required this.icon,
    this.secondaryIcon,
    this.onSecondaryTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(icon),
              const SizedBox(width: 16),
              AppText(
                text: title,
                size: 20,
                letterSpacing: -0.38,
              )
            ],
          ),
          if (secondaryIcon != null)
            InkWell(
                onTap: onSecondaryTap, child: SvgPicture.asset(secondaryIcon!)),
        ],
      ),
    );
  }
}
