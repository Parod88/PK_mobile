import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CircledImage extends StatelessWidget {
  final String icon;
  final Color background;
  final double diameter;
  const CircledImage({
    super.key,
    this.background = Colors.white,
    this.icon = '',
    this.diameter = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(icon.endsWith('.svg') ? 8 : 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: background,
        image: icon.endsWith('.svg')
            ? null
            : DecorationImage(
                image: AssetImage(icon),
                fit: BoxFit.cover,
              ),
      ),
      height: diameter,
      width: diameter,
      child: icon.endsWith('.svg')
          ? SvgPicture.asset(
              icon,
              fit: BoxFit.cover,
            )
          : null,
    );
  }
}
