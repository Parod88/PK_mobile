import 'package:flutter/material.dart';
import 'package:passkey/shared/styles/styles.dart';
import 'package:passkey/shared/utils/strings.dart';
import 'package:passkey/shared/widgets/facilitie_feature.dart';
import 'package:passkey/shared/widgets/texts/app_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DetailFeatures extends StatelessWidget {
  final List<String> features;
  const DetailFeatures({
    super.key,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    AppLocalizations t = AppLocalizations.of(context)!;

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: t.detail_facilities_title.capitalize(),
            size: 16,
            fontWeight: FontWeight.w600,
            lineHeight: 1.5,
            letterSpacing: -0.30,
            color: darkTextColor,
          ),
          const SizedBox(height: 12),
          Column(
            children: features
                .map((feature) => Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: FacilitieFeature(
                        feature: feature,
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
