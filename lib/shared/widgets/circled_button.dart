import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passkey/shared/widgets/texts/app_text.dart';

class CircledButton extends StatelessWidget {
  final Function onTap;
  final String? text;
  final String icon;
  final Color background;
  final double diameter;
  final double padding;

  const CircledButton({
    super.key,
    required this.onTap,
    this.background = Colors.white,
    this.text,
    this.icon = '',
    this.diameter = 40,
    this.padding = 8,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999), color: background),
          height: diameter,
          width: diameter,
          child: text != null
              ? AppText(text: text!)
              : SvgPicture.asset(
                  icon,
                )),
    );
  }
}
