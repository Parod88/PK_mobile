import 'package:flutter/material.dart';
import 'package:passkey/shared/styles/styles.dart';
import 'package:passkey/shared/theme/icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FilterBar extends StatelessWidget {
  final bool showFilter;
  final Function(String) onChange;
  static final TextEditingController searchController = TextEditingController();
  const FilterBar({super.key, this.showFilter = true, required this.onChange});

  @override
  Widget build(BuildContext context) {
    AppLocalizations t = AppLocalizations.of(context)!;
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: mediumGrey,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                AppIcons.searchIcon,
                height: 20,
              ),
              const SizedBox(width: 8),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 260),
                child: TextField(
                  controller: searchController,
                  onChanged: (String val) => onChange(val),
                  decoration: InputDecoration(
                    hintText: t.home_search,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
          if (showFilter)
            InkWell(
              onTap: () => print('Filter tapped'),
              child: Container(
                width: 40,
                height: 40,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: mediumGrey, width: 1)),
                child: Image.asset(
                  AppIcons.filterIcon,
                ),
              ),
            )
        ],
      ),
    );
  }
}
