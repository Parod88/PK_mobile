import 'package:flutter/material.dart';
import 'package:passkey/shared/styles/styles.dart';

class AppText extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight fontWeight;
  final Color? color;
  final double? letterSpacing;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? opacity;
  final double? lineHeight;
  final TextAlign align;
  final bool strike;

  const AppText({
    super.key,
    required this.text,
    this.size = 16,
    this.strike = false,
    this.maxLines,
    this.overflow,
    this.opacity,
    this.color,
    this.letterSpacing = -0.304,
    this.lineHeight = 1.5,
    this.fontWeight = FontWeight.w600,
    this.align = TextAlign.left,
  });

  @override
  Widget build(BuildContext context) {
    final title = Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: align,
      style: TextStyle(
        decoration: strike ? TextDecoration.lineThrough : TextDecoration.none,
        fontFamily: 'Open Sans',
        fontSize: size,
        height: lineHeight,
        fontWeight: fontWeight,
        color: color ?? darkTextColor.withOpacity(opacity ?? 1),
        letterSpacing: letterSpacing,
      ),
    );

    return SizedBox(
      child: title,
    );
  }
}
