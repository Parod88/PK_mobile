enum BuildingType {
  gym,
  apartment;

  factory BuildingType.fromName(String name) {
    switch (name) {
      case 'gym':
        return BuildingType.gym;
      case 'apartment':
        return BuildingType.apartment;
      default:
        throw Exception('Invalid type name');
    }
  }

  bool get isApartment => this == BuildingType.apartment;

  bool get isGym => this == BuildingType.gym;
}
