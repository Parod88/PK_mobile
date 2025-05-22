import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passkey/domain/models/building/building.dart';
import 'package:passkey/domain/models/building/gym.dart';
import 'package:passkey/shared/app_divider.dart';
import 'package:passkey/shared/styles/styles.dart';
import 'package:passkey/shared/theme/icons.dart';
import 'package:passkey/shared/utils/strings.dart';
import 'package:passkey/shared/widgets/facilitie_feature.dart';
import 'package:passkey/shared/widgets/texts/app_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DetailSlider extends StatefulWidget {
  final BuildingModel building;
  const DetailSlider({super.key, required this.building});

  @override
  DetailSliderState createState() => DetailSliderState();
}

class DetailSliderState extends State<DetailSlider> {
  bool showMore = false;

  @override
  Widget build(BuildContext context) {
    AppLocalizations t = AppLocalizations.of(context)!;

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 36),
              AppText(
                text: t.bookings_detail_info_title.capitalize(),
                size: 20,
                letterSpacing: -0.38,
              ),
              const SizedBox(height: 8),
              AppText(
                text: widget.building.name.capitalize(),
                size: 20,
                letterSpacing: -0.38,
              ),
              AppText(
                text: widget.building.address.capitalize(),
                fontWeight: FontWeight.w400,
                color: softTextColor,
              ),
              const AppDivider(mt: 12, mb: 12),
              AppText(text: t.detail_description_title.capitalize()),
              const SizedBox(height: 6),
              AppText(
                text: widget.building.description.capitalize(),
                color: neutralGrey,
                fontWeight: FontWeight.w400,
                overflow: showMore ? null : TextOverflow.ellipsis,
                maxLines: showMore ? null : 2,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    showMore = !showMore;
                  });
                },
                child: AppText(
                  text: showMore
                      //TODO change translation key to shared_
                      ? t.detail_description_show_less.capitalize()
                      : t.detail_description_show_more.capitalize(),
                  color: neutralGrey,
                  letterSpacing: -0.2,
                  size: 14,
                ),
              ),
              const AppDivider(mt: 12, mb: 12),
              SingleChildScrollView(
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.building.features.length,
                    itemBuilder: (context, index) {
                      return FacilitieFeature(
                        feature: widget.building.features[index],
                      );
                    }),
              ),
              const SizedBox(height: 12),
              AppText(text: t.bookings_detail_info_rules.capitalize()),
              const SizedBox(height: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: (widget.building as GymModel).rules.capitalize(),
                    color: neutralGrey,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                  ),
                  const SizedBox(height: 12),
                  AppText(
                      text:
                          t.bookings_detail_info_cancel_politics.capitalize()),
                  const SizedBox(height: 6),
                  AppText(
                    text: (widget.building as GymModel)
                        .cancelPolitics
                        .capitalize(),
                    color: neutralGrey,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                  )
                ],
              ),
            ],
          ),
        ),
        Positioned(
            top: 16,
            right: 16,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: SvgPicture.asset(AppIcons.crossCloseIcon),
            ))
      ],
    );
  }
}
