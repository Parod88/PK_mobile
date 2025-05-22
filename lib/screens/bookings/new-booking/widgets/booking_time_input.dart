import 'package:flutter/material.dart';
import 'package:passkey/screens/bookings/new-booking/widgets/booking_input.dart';

class BookingTimeInput extends StatelessWidget {
  final String icon;
  final String title;
  final String? bottomText;
  final bool isExpanded;
  final String? selectedTime;
  final List<String> availableTimes;
  final Function onTap;
  final Function(String) onSelected;

  const BookingTimeInput({
    super.key,
    required this.icon,
    required this.title,
    required this.bottomText,
    required this.isExpanded,
    required this.selectedTime,
    required this.availableTimes,
    required this.onTap,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BookingInput(
      icon: icon,
      title: title,
      bottomText: bottomText,
      isExpanded: isExpanded,
      expandedChild: GestureDetector(
        onTap: selectedTime != null ? () => onSelected(selectedTime!) : null,
        child: SizedBox(
          height: 150,
          child: ListWheelScrollView.useDelegate(
            controller: FixedExtentScrollController(
              initialItem: availableTimes.indexOf(selectedTime ?? ''),
            ),
            itemExtent: 32.0,
            physics: const FixedExtentScrollPhysics(),
            onSelectedItemChanged: (index) {},
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (context, index) {
                return Center(
                  child: Text(availableTimes[index]),
                );
              },
              childCount: availableTimes.length,
            ),
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
