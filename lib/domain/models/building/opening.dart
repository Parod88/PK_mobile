class Opening {
  final String open;
  final String close;

  Opening({
    required this.open,
    required this.close,
  });

  get openTime => open.split(":");
  get closeTime => close.split(":");

  List<DateTime> toDate(DateTime day) {
    final [openHour, openMinutes] = openTime;
    final [closeHour, closeMinutes] = closeTime;
    if (closeHour == '00') {}

    return [
      day.copyWith(
        hour: int.parse(openHour),
        minute: int.parse(openMinutes),
        second: 0,
        millisecond: 0,
        microsecond: 0,
      ),
      day.copyWith(
        hour: closeHour == '00' ? 23 : int.parse(closeHour),
        minute: closeHour == '00' ? 59 : int.parse(closeMinutes),
        second: 0,
        millisecond: 0,
        microsecond: 0,
      )
    ];
  }

  int compareTo(Opening other, DateTime day) {
    final [thisOpenAsDate, _] = toDate(day);
    final [otherOpenAsDate, _] = other.toDate(day);

    return thisOpenAsDate.compareTo(otherOpenAsDate);
  }

  bool contains(String time) {
    final [openDate, closeDate] = toDate(DateTime.now());
    final [hour, seconds] = time.split(':');
    final asDate = DateTime.now().copyWith(
      hour: int.parse(hour),
      minute: int.parse(seconds),
      second: 1,
      millisecond: 0,
      microsecond: 0,
    );

    final a = asDate.isBefore(closeDate) && asDate.isAfter(openDate);
    return a;
  }

  factory Opening.fromMap(Map<String, dynamic> map) {
    return Opening(
      open: map['open'],
      close: map['close'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'open': open,
      'close': close,
    };
  }
}
