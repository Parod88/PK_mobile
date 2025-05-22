enum BookingType {
  gym,
  apartment;

  factory BookingType.fromName(String name) {
    switch (name) {
      case 'gym':
        return BookingType.gym;
      case 'apartment':
        return BookingType.apartment;
      default:
        throw Exception('Invalid type name');
    }
  }

  String get name => this == BookingType.apartment ? 'apartment' : 'gym';
}
