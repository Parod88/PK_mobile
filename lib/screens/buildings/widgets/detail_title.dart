import 'package:flutter/material.dart';
import 'package:passkey/domain/models/building/building.dart';
import 'package:passkey/shared/styles/styles.dart';
import 'package:passkey/shared/widgets/texts/app_text.dart';

class DetailTitle extends StatelessWidget {
  final BuildingModel building;
  const DetailTitle({
    super.key,
    required this.building,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
              text: building.name,
              size: 20,
              fontWeight: FontWeight.w600,
              lineHeight: 1.5,
              letterSpacing: -0.38,
              color: darkTextColor),
          const SizedBox(height: 4),
          AppText(
            text: building.address,
            color: softTextColor,
            fontWeight: FontWeight.w400,
            lineHeight: 1.5,
            letterSpacing: -0.3,
            size: 16,
          ),
        ],
      ),
    );
  }
}
