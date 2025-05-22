import 'package:flutter/material.dart';
import 'package:passkey/domain/models/bookings/booking_model.dart';
import 'package:passkey/domain/models/bookings/booking_status.dart';
import 'package:passkey/domain/models/building/schedule.dart';
import 'package:passkey/domain/models/building/building.dart';

class Availability {
  final BuildingModel building;
  final List<BookingModel> bookings;

  const Availability({
    required this.building,
    required this.bookings,
  });

  List<BookingModel> _filter(DateTime date) {
    return bookings
        .where(
          (book) =>
              book.dates
                  .where(
                      (bookingDate) => DateUtils.isSameDay(bookingDate, date))
                  .isNotEmpty &&
              [BookingStatus.pending, BookingStatus.confirmed]
                  .contains(book.status),
        )
        .toList();
  }

  bool apartmentIsAvailable(DateTime date) {
    return _apartmentIsAvailable(date) &&
        _apartmentIsAvailable(date.copyWith(day: date.day + 1));
  }

  bool _apartmentIsAvailable(DateTime date) {
    final books = _filter(date);
    if (building.schedule.startAvailableHours(date).isEmpty) return false;
    if (books.isEmpty) return true;
    final booking = books.first;
    return DateUtils.isSameDay(booking.endDate, date);
  }

  List<String> calculateStartAvailableSpots(DateTime date) {
    final books = _filter(date);

    final slots = building.schedule.startAvailableHours(date);

    final List<List<String>> formattedBooks =
        books.map((book) => book.bookingTime.asString).toList();

    for (var [start, end] in formattedBooks) {
      final startIndex = slots.indexWhere((slot) => slot == start);
      final endIndex = slots.indexWhere((slot) => slot == end);
      if (startIndex >= 0 && endIndex >= 0) {
        slots.removeRange(
          startIndex > 0 ? startIndex - 1 : startIndex,
          endIndex + 1,
        );
      }
      if (startIndex < 0 && endIndex >= 0) {
        slots.removeAt(endIndex);
      }
    }

    return slots
        .where((slot) => calculateEndAvailableSpots(date, slot).isNotEmpty)
        .toList();
  }

  List<String> calculateEndAvailableSpots(
    DateTime date,
    String start,
  ) {
    final books = _filter(date);
    final slots = building.schedule.endAvailableHours(day: date, start: start);

    final List<String> formattedBooks =
        books.map((book) => book.bookingTime.asString.first).toList();

    final startIndex = slots.indexWhere((slot) => slot == start);
    final List<String> newSlots = [];

    final otherBookingStarts = slots.indexWhere(
      (i) => formattedBooks.indexWhere((c) => c == i) >= 0,
    );
    for (final (index, item) in slots.indexed) {
      // mínimo una hora
      if (index > startIndex + 1) {
        if (otherBookingStarts < startIndex) {
          newSlots.add(item);
        } else {
          if (index < otherBookingStarts) {
            newSlots.add(item);
          }
        }
      }
    }

    return newSlots;
  }
}
