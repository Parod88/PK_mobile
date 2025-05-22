import 'package:flutter/material.dart';
import 'package:passkey/shared/styles/styles.dart';
import 'package:passkey/shared/utils/strings.dart';
import 'package:passkey/shared/widgets/texts/app_text.dart';

class AppTagButton extends StatefulWidget {
  final String text;
  final String icon;
  final bool selected;

  const AppTagButton({
    super.key,
    required this.text,
    required this.icon,
    this.selected = false,
  });

  @override
  AppTagButtonState createState() => AppTagButtonState();
}

class AppTagButtonState extends State<AppTagButton> {
  bool selected = false;

  @override
  void initState() {
    selected = widget.selected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        setState(() {
          selected = !selected;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? darkTextColor : Colors.white,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: selected ? darkTextColor : mediumGrey,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image(
              image: AssetImage(widget.icon),
              color: selected ? Colors.white : softTextColor,
              width: 16,
              height: 16,
            ),
            const SizedBox(width: 8),
            AppText(
              text: widget.text.capitalize(),
              color: selected ? Colors.white : softTextColor,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
