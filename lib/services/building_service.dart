import 'package:passkey/data/repositories/building_repository.dart';
import 'package:passkey/domain/models/building/building_type.dart';

class BuildingService {
  final BuildingRepository _buildingRepository;

  BuildingService(this._buildingRepository);

  fetchBuildings([List<String> ids = const [], BuildingType? buildingType]) {
    return ids.isNotEmpty
        ? _buildingRepository.getBuildingsById(ids)
        : _buildingRepository.fetchBuildings(buildingType);
  }
}
