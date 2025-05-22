import 'package:flutter/material.dart';
import 'package:passkey/domain/models/building/building_type.dart';
import 'package:passkey/screens/bookings/bookings.dart';
import 'package:passkey/screens/buildings/favorites_buildings.dart';
import 'package:passkey/screens/home/home.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:passkey/screens/profile/profile.dart';

class UserSections {
  final AppLocalizations t;
  final BuildingType buildingType;

  UserSections(this.t, this.buildingType);

  List<Widget> get sections => <Widget>[
        Home(buildingType: buildingType),
        const BookingScreen(),
        const FavoritesBuildings(),
        const Profile(),
      ];

  List<BottomNavigationBarItem> get items => [
        BottomNavigationBarItem(
            icon: const Icon(
              Icons.home_outlined,
            ),
            label: t.sections_home),
        BottomNavigationBarItem(
            icon: const Icon(Icons.calendar_today_outlined),
            label: t.sections_bookings),
        BottomNavigationBarItem(
            icon: const Icon(
              Icons.favorite_border_outlined,
            ),
            label: t.sections_favs),
        BottomNavigationBarItem(
            icon: const Icon(
              Icons.person_outlined,
            ),
            label: t.sections_profile),
      ];
}
