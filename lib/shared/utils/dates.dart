import 'package:intl/intl.dart';
import 'package:passkey/shared/utils/strings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DateFormatter {
  static String onlyDate(date) => DateFormat('dd/MM/yyyy').format(date);

  static String getDate(date) => DateFormat('yyyy-MM-dd').format(date);

  static String onlyMonth(date) {
    return DateFormat.MMM().format(date).toString();
  }

  static String onlyDay(date) {
    return DateFormat.d().format(date).toString();
  }

  static String getDay(date) {
    return DateFormat.EEEE().format(date);
  }

  static String getMonthShort(date) {
    return DateFormatter.onlyMonth(date).capitalize().replaceAll(".", "");
  }

  static String getMonth(date) {
    return DateFormat.MMMM().format(date).capitalize();
  }

  static String getDayShort(date) {
    return DateFormatter.getDay(date).capitalize().substring(0, 3);
  }

  static String onlyTime(DateTime date) {
    return DateFormat.Hm().format(date);
  }

  static String formatLocalizedDate(AppLocalizations l10n, DateTime date) {
    String locale = Intl.getCurrentLocale();

    if (locale == 'es') {
      String day = DateFormat.d(locale).format(date);
      String month = DateFormat.MMMM(locale).format(date).toLowerCase();
      String year = DateFormat.y(locale).format(date);
      return "$day $month $year";
    } else {
      String day = DateFormat.d(locale).format(date);
      String month = DateFormat.MMMM(locale).format(date);
      String year = DateFormat.y(locale).format(date);
      return "$year, $month $day";
    }
  }

  static String formatMinutesToLocalizedHoursAndMinutes(
      AppLocalizations l10n, int totalMinutes) {
    int hours = totalMinutes ~/ 60;
    int minutes = totalMinutes % 60;

    if (hours > 0 && minutes > 0) {
      return '$hours ${l10n.shared_time_hours(hours)}  $minutes ${l10n.shared_time_minutes(minutes)}';
    } else if (hours > 0) {
      return '$hours ${l10n.shared_time_hours(hours)}';
    } else {
      return '$minutes ${l10n.shared_time_minutes(minutes)}';
    }
  }
}

extension MyDateUtils on DateTime {
  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }
}
