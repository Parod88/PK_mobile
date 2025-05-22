import 'package:flutter/material.dart';
import 'package:passkey/domain/models/building/building.dart';
import 'package:passkey/shared/widgets/cards/main_card.dart';

class BuildingMainCard extends StatelessWidget {
  final BuildingModel buildingModel;
  final Function onTap;

  const BuildingMainCard(
      {super.key, required this.buildingModel, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return MainCard(
      building: buildingModel,
      onTap: onTap,
    );
  }
}
