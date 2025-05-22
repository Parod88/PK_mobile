import 'package:flutter/material.dart';
import 'package:passkey/domain/models/building/building.dart';
import 'package:passkey/screens/buildings/widgets/building_main_card.dart';
import 'package:passkey/shared/routes/routes.dart';

class BuildingList extends StatelessWidget {
  final List<BuildingModel> buildings;

  const BuildingList({super.key, required this.buildings});

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: buildings.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: BuildingMainCard(
              buildingModel: buildings[index],
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Routes.buildingDetails,
                  arguments: buildings[index],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
