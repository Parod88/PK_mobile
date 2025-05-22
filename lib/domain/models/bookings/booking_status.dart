enum BookingStatus {
  pending,
  confirmed,
  cancelled,
  resolved;

  factory BookingStatus.fromValue(String value) {
    switch (value) {
      case 'pending':
        return BookingStatus.pending;
      case 'confirmed':
        return BookingStatus.confirmed;
      case 'cancelled':
        return BookingStatus.cancelled;
      case 'resolved':
        return BookingStatus.resolved;
      default:
        return BookingStatus.pending;
    }
  }
}

extension BookingStatusExtension on BookingStatus {
  String get name {
    switch (this) {
      case BookingStatus.cancelled:
        return 'cancelled';
      case BookingStatus.confirmed:
        return 'confirmed';
      case BookingStatus.pending:
        return 'pending';
      case BookingStatus.resolved:
        return 'resolved';
    }
  }
}
