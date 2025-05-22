import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passkey/shared/app_divider.dart';
import 'package:passkey/shared/styles/styles.dart';
import 'package:passkey/shared/widgets/texts/app_text.dart';

class BookingInput extends StatelessWidget {
  final String icon;
  final String title;
  final String? bottomText;
  final bool isExpanded;
  final Widget? expandedChild;
  final Function? onTap;
  final double expandedMb;
  final bool disabled;
  final bool withBorder;

  const BookingInput({
    super.key,
    required this.icon,
    required this.title,
    required this.bottomText,
    this.disabled = true,
    this.isExpanded = false,
    this.expandedChild,
    this.onTap,
    this.expandedMb = 10,
    this.withBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: withBorder ? Border.all(color: clearGrey) : null,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 32),
        child: Column(
          mainAxisAlignment: bottomText != null
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => onTap?.call(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    icon,
                    color: disabled && !isExpanded ? mediumGrey : primaryColor,
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: title,
                          size: 14,
                          letterSpacing: -0.26,
                          color: disabled && !isExpanded ? mediumGrey : null,
                        ),
                        if (bottomText != null)
                          Row(
                            children: [
                              Expanded(
                                child: AppText(
                                  text: bottomText!,
                                  size: 10,
                                  lineHeight: 1.2,
                                  letterSpacing: 0,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            if (isExpanded && expandedChild != null)
              Column(
                children: [
                  AppDivider(
                    mt: 6,
                    mb: expandedMb,
                    color: mediumGrey,
                  ),
                  expandedChild!
                ],
              )
          ],
        ),
      ),
    );
  }
}
