import 'package:flutter/material.dart';
import 'package:passkey/shared/styles/styles.dart';
import 'package:passkey/shared/widgets/texts/app_text.dart';

class MainButton extends StatelessWidget {
  final double height;
  final double width;
  final Color bgColor;
  final double borderRadius;
  final String btnText;
  final Color textColor;
  final Function? onTap;

  const MainButton({
    super.key,
    this.height = 50,
    this.width = double.infinity,
    this.bgColor = primaryColor,
    this.borderRadius = 12,
    required this.btnText,
    this.textColor = Colors.white,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap != null ? () => onTap!() : null,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: AppText(
            text: btnText,
            size: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
