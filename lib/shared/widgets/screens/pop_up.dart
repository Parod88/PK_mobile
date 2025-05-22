import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passkey/shared/theme/icons.dart';

class PopUp extends StatelessWidget {
  final Widget child;
  final void Function(BuildContext) onPressed;
  final double? marginBottom;
  final double px;
  final double insidePx;
  final double insidePy;
  final double? mt;
  final Color? _color;
  final bool hasColor;
  final double borderRadius;
  final bool closeBtn;

  PopUp({
    super.key,
    required this.child,
    this.onPressed = _defaultOnPressed,
    this.marginBottom,
    this.px = 27,
    this.insidePx = 16,
    this.insidePy = 32,
    this.mt,
    Color? color,
    this.hasColor = true,
    this.borderRadius = 15,
    this.closeBtn = true,
  }) : _color = hasColor ? (color ?? Colors.black).withOpacity(0.3) : null;

  static void _defaultOnPressed(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: px),
        color: _color,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment:
              mt != null ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: mt ?? 0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: Border.all(
                      width: 2, color: Theme.of(context).colorScheme.surface)),
              padding: EdgeInsets.symmetric(
                horizontal: insidePx,
                vertical: insidePy,
              ),
              child: Stack(
                children: [
                  child,
                  if (closeBtn)
                    Positioned(
                      right: 0,
                      top: 17,
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        child: SvgPicture.asset(
                          AppIcons.leftArrowIcon,
                          width: 32,
                          height: 32,
                        ),
                        onTap: () => onPressed(context),
                      ),
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
