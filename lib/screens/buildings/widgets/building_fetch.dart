import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passkey/domain/models/building/building_type.dart';
import 'package:passkey/screens/buildings/widgets/building_list.dart';
import 'package:passkey/shared/styles/styles.dart';
import 'package:passkey/shared/bloc/buildings/buildings_state.dart';
import 'package:passkey/shared/bloc/buildings/buildings_cubit.dart';

class BuildingFetcher extends StatefulWidget {
  final String filter;
  final List<String> buildingsId;
  final BuildingType? buildingType;
  const BuildingFetcher({
    super.key,
    this.buildingsId = const [],
    this.filter = "",
    this.buildingType,
  });

  @override
  State<BuildingFetcher> createState() => _BuildingFetcherState();
}

class _BuildingFetcherState extends State<BuildingFetcher> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BuildingsCubit>(context).fetchBuildings(
      widget.buildingsId,
      widget.buildingType,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuildingsCubit, BuildingsState>(
      builder: (context, state) {
        if (state is BuildingsLoading) {
          return const Center(
              child: CircularProgressIndicator(
            color: primaryColor,
          ));
        }
        if (state is BuildingsSuccess) {
          return BuildingList(
            buildings: widget.filter.isEmpty
                ? state.buildings
                : state.buildings
                    .where((building) => building.name.contains(widget.filter))
                    .toList(),
          );
        }
        return Container();
      },
    );
  }
}
