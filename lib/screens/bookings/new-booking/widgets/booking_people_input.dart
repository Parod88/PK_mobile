import 'package:flutter/material.dart';
import 'package:passkey/screens/bookings/new-booking/widgets/booking_input.dart';

class BookingPeopleInput extends StatelessWidget {
  final String icon;
  final String title;
  final String? bottomText;
  final bool isExpanded;
  final int selectedPeople;
  final Function onTap;
  final void onPeopleSelected;
  final Function onPeopleChange;

  const BookingPeopleInput({
    super.key,
    required this.icon,
    required this.title,
    required this.bottomText,
    required this.isExpanded,
    required this.selectedPeople,
    required this.onTap,
    required this.onPeopleSelected,
    required this.onPeopleChange,
  });

  @override
  Widget build(BuildContext context) {
    return BookingInput(
      icon: icon,
      title: title,
      bottomText: bottomText,
      isExpanded: isExpanded,
      expandedChild: GestureDetector(
        onTap: () => onPeopleSelected,
        child: SizedBox(
          height: 150,
          child: ListWheelScrollView.useDelegate(
            controller: FixedExtentScrollController(
              initialItem: selectedPeople - 1,
            ),
            itemExtent: 32.0,
            physics: const FixedExtentScrollPhysics(),
            onSelectedItemChanged: (index) {
              onPeopleChange(index + 1);
            },
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (context, index) {
                return Center(
                  child: Text('${index + 1}'),
                );
              },
              childCount: 10,
            ),
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
