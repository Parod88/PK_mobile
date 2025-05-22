import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:passkey/domain/models/building/building_type.dart';
import 'package:passkey/screens/home/widgets/filter_search_bar.dart';
import 'package:passkey/shared/theme/icons.dart';
import 'package:passkey/screens/buildings/widgets/building_fetch.dart';
import 'package:passkey/shared/widgets/buttons/tag_button.dart';
import 'package:passkey/shared/widgets/screen_layout.dart';

class Home extends StatefulWidget {
  final bool useTags;
  final BuildingType buildingType;
  const Home({super.key, this.useTags = false, required this.buildingType});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String filter = "";

  @override
  Widget build(BuildContext context) {
    AppLocalizations t = AppLocalizations.of(context)!;

    return ScreenLayout(
      pl: 19,
      pr: 19,
      pt: 65,
      child: Column(
        children: [
          FilterBar(
              showFilter: false,
              onChange: (String val) => setState(() => filter = val)),
          const SizedBox(height: 24),
          if (widget.useTags) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AppTagButton(text: t.tags_filter_all, icon: AppIcons.all),
                const SizedBox(width: 8),
                AppTagButton(text: t.tags_filter_groups, icon: AppIcons.group),
              ],
            ),
            const SizedBox(height: 24),
          ],
          Expanded(
              child: BuildingFetcher(
            filter: filter,
            buildingType: widget.buildingType,
          ))
        ],
      ),
    );
  }
}
