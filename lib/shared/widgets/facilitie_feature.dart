import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passkey/shared/theme/icons.dart';
import 'package:passkey/shared/utils/strings.dart';
import 'package:passkey/shared/widgets/texts/app_text.dart';

class FacilitieFeature extends StatelessWidget {
  final String feature;
  const FacilitieFeature({
    super.key,
    required this.feature,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(
          AppIcons.checkIcon,
          width: 20,
          height: 20,
        ),
        const SizedBox(width: 8),
        AppText(
          text: feature.capitalize(),
          size: 14,
          fontWeight: FontWeight.w400,
          lineHeight: 1.5,
          letterSpacing: -0.266,
        )
      ],
    );
  }
}
