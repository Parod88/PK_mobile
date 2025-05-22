import 'package:flutter/material.dart';
import 'package:passkey/screens/bookings/bookings.dart';
import 'package:passkey/shared/styles/styles.dart';
import 'package:passkey/shared/widgets/texts/app_text.dart';

class ToggleBookings extends StatefulWidget {
  final String tab1Title;
  final String tab2Title;
  final Function(BookingScreenMode) onToggle;

  const ToggleBookings({
    super.key,
    required this.tab1Title,
    required this.onToggle,
    required this.tab2Title,
  });

  @override
  ToggleBookingsState createState() => ToggleBookingsState();
}

class ToggleBookingsState extends State<ToggleBookings> {
  bool isSelected = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      height: 53,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  isSelected = true;
                });
                widget.onToggle(BookingScreenMode.current);
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                height: 37,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: AppText(
                  text: widget.tab1Title.toUpperCase(),
                  size: 14,
                  fontWeight: FontWeight.w600,
                  lineHeight: 1.5,
                  letterSpacing: -0.26,
                  align: TextAlign.center,
                  color: isSelected ? darkTextColor : Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  isSelected = false;
                });
                widget.onToggle(BookingScreenMode.history);
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                height: 37,
                decoration: BoxDecoration(
                  color: !isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: AppText(
                  text: widget.tab2Title.toUpperCase(),
                  size: 14,
                  fontWeight: FontWeight.w600,
                  lineHeight: 1.5,
                  letterSpacing: -0.26,
                  align: TextAlign.center,
                  color: !isSelected ? darkTextColor : Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
