import 'package:flutter/material.dart';
import 'package:passkey/domain/models/building/building.dart';
import 'package:passkey/shared/styles/styles.dart';
import 'package:passkey/shared/utils/strings.dart';
import 'package:passkey/shared/widgets/texts/app_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DetailDescription extends StatefulWidget {
  final BuildingModel building;
  const DetailDescription({
    super.key,
    required this.building,
  });
  @override
  DetailDescriptionState createState() => DetailDescriptionState();
}

class DetailDescriptionState extends State<DetailDescription> {
  bool showMore = false;

  @override
  Widget build(BuildContext context) {
    AppLocalizations t = AppLocalizations.of(context)!;

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: t.detail_description_title.capitalize(),
            size: 16,
            fontWeight: FontWeight.w600,
            lineHeight: 1.5,
            letterSpacing: -0.30,
            color: darkTextColor,
          ),
          const SizedBox(height: 6),
          AppText(
            text: widget.building.description,
            overflow: showMore ? null : TextOverflow.ellipsis,
            color: neutralGrey,
            fontWeight: FontWeight.w400,
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
                  ? t.detail_description_show_less.capitalize()
                  : t.detail_description_show_more.capitalize(),
              color: neutralGrey,
              letterSpacing: -0.2,
              size: 14,
            ),
          ),
        ],
      ),
    );
  }
}
