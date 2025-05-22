import 'package:flutter/material.dart';
import 'package:passkey/domain/models/bookings/availability.dart';
import 'package:passkey/screens/bookings/new-booking/domain/partial_booking.dart';
import 'package:passkey/screens/bookings/new-booking/widgets/booking_calendar.dart';
import 'package:passkey/screens/bookings/new-booking/widgets/booking_input.dart';
import 'package:passkey/shared/styles/styles.dart';
import 'package:passkey/shared/theme/icons.dart';
import 'package:passkey/shared/utils/dates.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewBookingForm extends StatefulWidget {
  final Availability availability;
  final PartialBooking partialBooking;

  final Function({
    String? start,
    String? end,
    int? people,
    List<DateTime>? dates,
  }) updatePartialBooking;
  final Function() clean;

  const NewBookingForm({
    super.key,
    required this.availability,
    required this.partialBooking,
    required this.updatePartialBooking,
    required this.clean,
  });

  @override
  _NewBookingFormState createState() => _NewBookingFormState();
}

class _NewBookingFormState extends State<NewBookingForm> {
  List<DateTime> selectedDates = [];
  DateTime focusedDate = DateTime.now();

  late List<String> startSlots = [];
  List<String> endSlots = [];

  bool isPeopleExpanded = false;
  bool isStartTimeExpanded = false;
  bool isEndTimeExpanded = false;
  bool isDateExpanded = false;

  void _toggleDatePicker() {
    setState(() {
      isDateExpanded = !isDateExpanded;
    });
  }

  void _togglePeoplePicker() {
    setState(() {
      isPeopleExpanded = !isPeopleExpanded;
    });
  }

  void _toggleStartTimePicker() {
    if (startSlots.isEmpty) return;
    setState(() {
      isStartTimeExpanded = !isStartTimeExpanded;
    });
  }

  void _toggleEndTimePicker() {
    if (endSlots.isEmpty) return;
    setState(() {
      isEndTimeExpanded = !isEndTimeExpanded;
    });
  }

  _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    if (start == null || end == null) return;

    final List<DateTime> bookingDates = [start];
    int prevDay = start.day;
    for (var day = start.day + 1; day <= end.day; day++) {
      if (widget.availability
              .calculateStartAvailableSpots(start.copyWith(day: day))
              .isNotEmpty &&
          prevDay == day - 1) {
        bookingDates.add(start.copyWith(day: day));
        prevDay = day;
      }
    }

    final List<List<String>> allStartSlotsAux = bookingDates
        .map((date) => widget.availability.calculateStartAvailableSpots(
              date,
            ))
        .toList();

    final List<String> matchingSlots =
        allStartSlotsAux.reduce((matching, currentSlots) {
      if (matching.isEmpty) return currentSlots;
      return matching.where((slot) => currentSlots.contains(slot)).toList();
    });

    final endSlotsAux = widget.availability.calculateEndAvailableSpots(
      start,
      matchingSlots.first,
    );

    widget.updatePartialBooking(
      dates: bookingDates,
      start: matchingSlots.first,
      end: endSlotsAux.first,
    );

    setState(() {
      startSlots = matchingSlots;
      endSlots = endSlotsAux;
      focusedDate = bookingDates.first;
    });
  }

  _onDaySelected(
    DateTime selectedDay,
    DateTime focusedDay,
  ) {
    final startSlotsAux = widget.availability.calculateStartAvailableSpots(
      selectedDay,
    );

    final endSlotsAux = widget.availability
        .calculateEndAvailableSpots(selectedDay, startSlotsAux[0]);

    widget.updatePartialBooking(
      dates: [selectedDay],
      start: startSlotsAux.first,
      end: endSlotsAux.first,
    );

    setState(() {
      focusedDate = selectedDay;
      startSlots = startSlotsAux;
      endSlots = endSlotsAux;
    });
  }

  _onStartChanged(int index) {
    final start = startSlots[index];

    final endSlotsAux = widget.availability.calculateEndAvailableSpots(
      widget.partialBooking.dates.first,
      start,
    );

    widget.updatePartialBooking(start: start, end: endSlotsAux.first);

    setState(() => endSlots = endSlotsAux);
  }

  _onEndChanged(int index) {
    if (widget.partialBooking.start == null) return;

    widget.updatePartialBooking(end: endSlots[index]);
  }

  _onPeopleChanged(int people) {
    widget.updatePartialBooking(people: people);
  }

  void onCancel() {
    setState(() => isDateExpanded = false);
  }

  void onOk() {
    setState(() {
      isDateExpanded = false;
    });
  }

  String? calendarSubTitle(AppLocalizations t) {
    if (widget.partialBooking.dates.isEmpty) return null;
    if (widget.partialBooking.dates.length == 1) {
      return DateFormatter.formatLocalizedDate(
        t,
        widget.partialBooking.dates.first,
      );
    }
    return '${DateFormatter.onlyDate(
      widget.partialBooking.dates.first,
    )} - ${DateFormatter.onlyDate(
      widget.partialBooking.dates.last,
    )}';
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations t = AppLocalizations.of(context)!;
    PartialBooking partialBooking = widget.partialBooking;

    return Column(
      children: [
        BookingInput(
          icon: AppIcons.calendarIcon,
          title: t.bookings_detail_date,
          disabled: partialBooking.dates.isEmpty,
          bottomText: calendarSubTitle(t),
          isExpanded: isDateExpanded,
          expandedMb: 0,
          expandedChild: BookingCalendar(
            availability: widget.availability,
            focusedDate: focusedDate,
            selectedDates: partialBooking.dates,
            onDaySelected: _onDaySelected,
            onRangeSelected: _onRangeSelected,
            onClean: widget.clean,
            onCancel: onCancel,
            onOk: onOk,
            building: partialBooking.building,
          ),
          onTap: _toggleDatePicker,
        ),
        const SizedBox(height: 12),
        BookingInput(
          icon: AppIcons.groupSvg,
          title: t.bookings_detail_people,
          disabled: partialBooking.people <= 0,
          bottomText: partialBooking.people > 0
              ? '${partialBooking.people} ${t.bookings_detail_number_people(partialBooking.people)}'
              : null,
          isExpanded: isPeopleExpanded,
          expandedChild: GestureDetector(
            onTap: _togglePeoplePicker,
            child: _peopleSelect(widget.partialBooking.people),
          ),
          onTap: _togglePeoplePicker,
        ),
        const SizedBox(height: 12),
        _startSelect(t, partialBooking),
        const SizedBox(height: 12),
        _endSelect(t, partialBooking),
      ],
    );
  }

  Widget _startSelect(AppLocalizations t, PartialBooking partialBooking) {
    return partialBooking.building.type.isApartment
        ? BookingInput(
            icon: AppIcons.clockIcon,
            title: t.check_in,
            bottomText: partialBooking.start,
            withBorder: false,
            disabled: false,
            isExpanded: false,
          )
        : BookingInput(
            icon: AppIcons.clockIcon,
            title: t.bookings_new_available_hours_start,
            bottomText: partialBooking.start,
            disabled: partialBooking.dates.isEmpty,
            isExpanded: isStartTimeExpanded,
            expandedChild: GestureDetector(
              onTap:
                  partialBooking.start == null ? null : _toggleStartTimePicker,
              child: partialBooking.start != null
                  ? _dateSelect(
                      startSlots, _onStartChanged, partialBooking.start)
                  : Container(),
            ),
            onTap: _toggleStartTimePicker,
          );
  }

  Widget _endSelect(AppLocalizations t, PartialBooking partialBooking) {
    return partialBooking.building.type.isApartment
        ? BookingInput(
            icon: AppIcons.clockIcon,
            title: t.check_out,
            bottomText: partialBooking.end,
            withBorder: false,
            disabled: false,
            isExpanded: false,
          )
        : BookingInput(
            icon: AppIcons.clockIcon,
            title: t.bookings_new_available_hours_end,
            disabled: partialBooking.start == null,
            bottomText: partialBooking.end,
            isExpanded: isEndTimeExpanded,
            expandedChild: GestureDetector(
              onTap: () =>
                  partialBooking.end == null ? null : _toggleEndTimePicker(),
              child: partialBooking.start != null && partialBooking.end != null
                  ? _dateSelect(endSlots, _onEndChanged, partialBooking.end)
                  : Container(),
            ),
            onTap: _toggleEndTimePicker,
          );
  }

  Widget _dateSelect(
      List<String> options, Function onChange, String? selected) {
    return SizedBox(
      height: 150,
      child: ListWheelScrollView.useDelegate(
        controller: FixedExtentScrollController(
          initialItem: options.indexOf(widget.partialBooking.start!),
        ),
        itemExtent: 32.0,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: (index) => onChange(index),
        childDelegate: ListWheelChildBuilderDelegate(
          builder: (context, index) {
            return Center(
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                  decoration: BoxDecoration(
                      color: options[index] == selected ? clearGrey : null,
                      borderRadius: const BorderRadius.all(Radius.circular(2))),
                  child: Text(options[index])),
            );
          },
          childCount: options.length,
        ),
      ),
    );
  }

  Widget _peopleSelect(int selected) {
    return SizedBox(
      height: 139,
      child: ListWheelScrollView.useDelegate(
        controller: FixedExtentScrollController(
          initialItem: 1,
        ),
        itemExtent: 25,
        onSelectedItemChanged: (index) {
          _onPeopleChanged(index + 1);
        },
        childDelegate: ListWheelChildBuilderDelegate(
          builder: (context, index) {
            return Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                decoration: BoxDecoration(
                    color: (index + 1) == selected ? clearGrey : null,
                    borderRadius: const BorderRadius.all(Radius.circular(2))),
                child: Text('${index + 1}'),
              ),
            );
          },
          childCount: widget.partialBooking.building.maxCapacity,
        ),
      ),
    );
  }
}
