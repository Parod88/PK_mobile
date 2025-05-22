import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:passkey/domain/models/building/opening.dart';

enum WeekDay {
  sunday,
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday;

  factory WeekDay.fromName(String name) {
    switch (name) {
      case 'sunday':
        return WeekDay.sunday;
      case 'monday':
        return WeekDay.monday;
      case 'tuesday':
        return WeekDay.tuesday;
      case 'wednesday':
        return WeekDay.wednesday;
      case 'thursday':
        return WeekDay.thursday;
      case 'friday':
        return WeekDay.friday;
      case 'saturday':
        return WeekDay.saturday;
      default:
        throw Exception('Invalid day name');
    }
  }
  factory WeekDay.fromNumber(int weekday) {
    switch (weekday) {
      case 7:
        return WeekDay.sunday;
      case 1:
        return WeekDay.monday;
      case 2:
        return WeekDay.tuesday;
      case 3:
        return WeekDay.wednesday;
      case 4:
        return WeekDay.thursday;
      case 5:
        return WeekDay.friday;
      case 6:
        return WeekDay.saturday;
      default:
        throw Exception('Invalid day name');
    }
  }
}

extension Schedule on Map<WeekDay, List<Opening>> {
  static Map<WeekDay, List<Opening>> fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final Map<WeekDay, List<Opening>> schedule = {};
    for (var item in (data['schedule'] as Map).entries) {
      schedule.putIfAbsent(
        WeekDay.fromName(item.key),
        () => (item.value as List<dynamic>)
            .map<Opening>((opening) => Opening.fromMap(opening))
            .toList(),
      );
    }
    return schedule;
  }

  List<String> startAvailableHours(DateTime day) {
    final openings = this[WeekDay.fromNumber(day.weekday)];
    if (openings == null || openings.isEmpty) return [];
    openings.sort((a, b) => a.compareTo(b, day));

    List<String> slots = [];

    for (var opening in openings) {
      final [open, close] = opening.toDate(day);
      final today = DateTime.now();
      final startHour =
          DateUtils.isSameDay(today, day) ? today.hour + 1 : open.hour;

      for (int hour = startHour; hour <= close.hour - 1; hour++) {
        final slotOclock = '${hour.toString().padLeft(2, '0')}:00';
        final slotAndAHalf = '${hour.toString().padLeft(2, '0')}:30';

        if (startHour == hour && open.minute > 0) {
          slots.add(slotAndAHalf);
        } else {
          slots.add(slotOclock);
          // you can not start half an hour before it closes
          if (hour < close.hour - 1) {
            slots.add(slotAndAHalf);
          }
        }
      }
    }

    return slots;
  }

  List<String> endAvailableHours({
    required DateTime day,
    required String start,
  }) {
    final openings = this[WeekDay.fromNumber(day.weekday)];
    if (openings == null || openings.isEmpty) return [];

    final opening = openings.firstWhere((op) => op.contains(start));

    List<String> slots = [];

    final [open, close] = opening.toDate(day);
    final today = DateTime.now();
    final startHour =
        DateUtils.isSameDay(today, day) ? today.hour + 1 : open.hour;

    for (int hour = startHour; hour <= close.hour; hour++) {
      slots.add('${hour.toString().padLeft(2, '0')}:00');
      slots.add('${hour.toString().padLeft(2, '0')}:30');
    }

    return slots;
  }
}
