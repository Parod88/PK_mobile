import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:passkey/domain/models/building/building_type.dart';
import 'package:passkey/navigation/domain/user_sections.dart';
import 'package:passkey/shared/styles/styles.dart';

class Layout extends StatefulWidget {
  final BuildingType modality;
  const Layout({
    super.key,
    required this.modality,
  });

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userSections = UserSections(
      AppLocalizations.of(context)!,
      widget.modality,
    );

    return Scaffold(
      body: IndexedStack(index: _currentPage, children: userSections.sections),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Container(
          decoration: const BoxDecoration(
              border: Border(
            top: BorderSide(color: mediumGrey, width: 1),
          )),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            selectedItemColor: darkTextColor,
            unselectedItemColor: darkTextColor,
            selectedIconTheme: const IconThemeData(color: primaryColor),
            unselectedIconTheme: const IconThemeData(color: softTextColor),
            selectedLabelStyle:
                const TextStyle(color: darkTextColor, fontSize: 12),
            elevation: 1,
            currentIndex: _currentPage,
            onTap: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            items: userSections.items,
          ),
        ),
      ),
    );
  }
}
