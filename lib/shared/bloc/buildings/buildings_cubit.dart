import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passkey/domain/models/building/building_type.dart';
import 'package:passkey/services/building_service.dart';
import 'package:passkey/shared/bloc/buildings/buildings_state.dart';

class BuildingsCubit extends Cubit<BuildingsState> {
  final BuildingService _buildingService;

  BuildingsCubit(
    this._buildingService,
  ) : super(BuildingsInitial());

  void fetchBuildings(
      [List<String> ids = const [], BuildingType? buildingType]) async {
    emit(BuildingsLoading());
    final buildings = await _buildingService.fetchBuildings(ids, buildingType);

    emit(BuildingsSuccess(buildings: buildings));
  }
}
