class BookingTime {
  final String start;
  final String end;

  BookingTime({required this.start, required this.end});

  get startTime => start.split(':');
  get endTime => end.split(':');

  List<DateTime> toDate([DateTime? date]) {
    final date0 = date ?? DateTime.now();
    final [startHour, startMinutes] = startTime;
    final [endHour, endMinutes] = endTime;
    return [
      date0.copyWith(
        hour: int.parse(startHour),
        minute: int.parse(startMinutes),
        second: 0,
        millisecond: 0,
        microsecond: 0,
      ),
      date0.copyWith(
        hour: int.parse(endHour),
        minute: int.parse(endMinutes),
        second: 0,
        millisecond: 0,
        microsecond: 0,
      )
    ];
  }

  Duration get duration {
    final [startDate, endDate] = toDate();
    return endDate.difference(startDate);
  }

  List<String> get asString => [start, end];

  factory BookingTime.fromMap(Map<String, dynamic> map) {
    return BookingTime(
      start: map['start'],
      end: map['end'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'start': start,
      'end': end,
    };
  }
}
