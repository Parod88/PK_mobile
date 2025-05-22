import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passkey/shared/styles/styles.dart';
import 'package:passkey/shared/theme/icons.dart';
import 'package:passkey/shared/utils/strings.dart';
import 'package:passkey/shared/widgets/texts/app_text.dart';

class ProfileEntry extends StatelessWidget {
  final String icon;
  final String text;
  final String? route;
  final Function? onTap;

  const ProfileEntry({
    required this.icon,
    required this.text,
    this.route,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: route != null
          ? () => Navigator.pushNamed(context, route!)
          : onTap != null
              ? () => onTap!()
              : () => print('No route provided'),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(icon),
              const SizedBox(width: 16),
              AppText(
                text: text.capitalize(),
                color: darkTextColor,
              )
            ],
          ),
          SvgPicture.asset(AppIcons.rightArrowIcon),
        ],
      ),
    );
  }
}
