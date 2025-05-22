import 'package:flutter/material.dart';
import 'package:passkey/domain/models/bookings/availability.dart';
import 'package:passkey/domain/models/building/building.dart';
import 'package:passkey/shared/styles/styles.dart';
import 'package:passkey/shared/widgets/texts/app_text.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookingCalendar extends StatefulWidget {
  final DateTime focusedDate;
  final List<DateTime> selectedDates;
  final Function(DateTime, DateTime) onDaySelected;
  final Function(DateTime?, DateTime?, DateTime) onRangeSelected;
  final VoidCallback onClean;
  final VoidCallback onCancel;
  final VoidCallback onOk;
  final Availability availability;
  final BuildingModel building;

  const BookingCalendar({
    super.key,
    required this.focusedDate,
    required this.selectedDates,
    required this.onDaySelected,
    required this.onClean,
    required this.onCancel,
    required this.onOk,
    required this.availability,
    required this.onRangeSelected,
    required this.building,
  });

  @override
  BookingCalendarState createState() => BookingCalendarState();
}

class BookingCalendarState extends State<BookingCalendar> {
  late RangeSelectionMode _rangeMode;
  bool get _isDaySelected => widget.selectedDates.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _rangeMode = widget.building.type.isApartment
        ? RangeSelectionMode.enforced
        : RangeSelectionMode.toggledOff;
  }

  void _onDayLongPressed(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      if (_rangeMode == RangeSelectionMode.toggledOff) {
        _rangeMode = RangeSelectionMode.toggledOn;
        widget.onRangeSelected(selectedDay, null, focusedDay);
      } else {
        widget.onRangeSelected(null, null, focusedDay);
        _rangeMode = RangeSelectionMode.toggledOff;
        widget.onDaySelected(selectedDay, focusedDay);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations t = AppLocalizations.of(context)!;

    TextStyle defaultTextStyle = const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontSize: 12,
      fontFamily: 'OpenSans',
      height: 1.2,
    );

    TextStyle defaultDisabledTextStyle = const TextStyle(
      color: mediumGrey,
      fontWeight: FontWeight.w400,
      fontSize: 12,
      fontFamily: 'OpenSans',
      height: 1.2,
    );

    return Column(
      children: [
        TableCalendar(
          focusedDay: widget.focusedDate,
          firstDay: DateTime.now(),
          lastDay: DateTime(
            DateTime.now().year,
            DateTime.now().month + 3,
            0,
          ),
          selectedDayPredicate: (day) {
            return isSameDay(widget.selectedDates.firstOrNull, day);
          },
          onDaySelected:
              widget.building.type.isGym ? widget.onDaySelected : null,
          daysOfWeekStyle: DaysOfWeekStyle(
            dowTextFormatter: (date, locale) =>
                DateFormat.E(locale).format(date).substring(0, 1),
            weekdayStyle: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 12,
              color: Colors.black,
              fontWeight: FontWeight.w400,
              height: 1.2,
            ),
            weekendStyle: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 12,
              color: Colors.black,
              fontWeight: FontWeight.w400,
              height: 1.2,
            ),
          ),
          rowHeight: 28,
          rangeStartDay: widget.selectedDates.firstOrNull,
          onDayLongPressed:
              widget.building.type.isGym ? _onDayLongPressed : null,
          rangeEndDay: widget.selectedDates.lastOrNull,
          onRangeSelected: widget.onRangeSelected,
          rangeSelectionMode: _rangeMode,
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: false,
          ),
          enabledDayPredicate: (day) => widget.building.type.isApartment
              ? widget.availability.apartmentIsAvailable(day)
              : widget.availability
                  .calculateStartAvailableSpots(day)
                  .isNotEmpty,
          calendarBuilders: CalendarBuilders(
            headerTitleBuilder: (context, day) {
              final text = DateFormat.yMMMM().format(day);
              return Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
              border: Border.all(
                color: clearGrey,
                width: 1,
              ),
              shape: BoxShape.circle,
            ),
            todayTextStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 12,
              fontFamily: 'OpenSans',
              height: 1.2,
            ),
            defaultTextStyle: defaultTextStyle,
            weekendTextStyle: defaultTextStyle,
            disabledTextStyle: defaultDisabledTextStyle,
            outsideTextStyle: defaultDisabledTextStyle,
            rangeEndTextStyle: defaultTextStyle,
            withinRangeTextStyle: defaultTextStyle,
            selectedTextStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 12,
              fontFamily: 'OpenSans',
              height: 1.2,
            ),
            selectedDecoration: const BoxDecoration(
              color: primaryColor,
              shape: BoxShape.circle,
            ),
            cellMargin: const EdgeInsets.all(3),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: widget.onClean,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: AppText(
                  text: t.bookings_new_calendar_btn_clean.toUpperCase(),
                  size: 10,
                  lineHeight: 1.2,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: widget.onCancel,
                  child: AppText(
                    text: t.bookings_new_calendar_btn_cancel.toUpperCase(),
                    size: 10,
                    lineHeight: 1.2,
                  ),
                ),
                const SizedBox(width: 14),
                InkWell(
                  onTap: _isDaySelected ? widget.onOk : null,
                  child: AppText(
                    text: t.bookings_new_calendar_btn_ok.toUpperCase(),
                    size: 10,
                    lineHeight: 1.2,
                    color: _isDaySelected ? primaryColor : softTextColor,
                  ),
                ),
                const SizedBox(width: 12),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
