import 'package:flutter/material.dart';
import 'package:passkey/shared/app_divider.dart';
import 'package:passkey/shared/routes/routes.dart';
import 'package:passkey/shared/styles/styles.dart';
import 'package:passkey/shared/theme/icons.dart';
import 'package:passkey/shared/widgets/buttons/main_button.dart';
import 'package:passkey/shared/widgets/circled_button.dart';

class ButtonProps {
  final String text;
  final Function() onTap;
  final bool disabled;
  const ButtonProps({
    required this.text,
    required this.onTap,
    required this.disabled,
  });
}

class ScreenImageLayout extends StatelessWidget {
  final Widget child;
  final double height;
  final String headerImg;
  final String leftIcon;
  final String? rightIcon;
  final double rightPadding;
  final ButtonProps? buttonProps;

  final Function()? rightOnTap;

  const ScreenImageLayout({
    super.key,
    required this.child,
    this.height = 334,
    required this.headerImg,
    this.leftIcon = AppIcons.leftArrowIcon,
    this.rightIcon,
    this.rightPadding = 8,
    this.rightOnTap,
    this.buttonProps,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  height: height,
                  child: Image.asset(
                    headerImg,
                    fit: BoxFit.cover,
                  ),
                ),
                child,
              ],
            ),
          ),
          Positioned(
            top: 65,
            left: 18,
            right: 18,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircledButton(
                  onTap: () => Navigator.pop(context),
                  icon: leftIcon,
                ),
                if (rightIcon != null)
                  CircledButton(
                    onTap: rightOnTap ??
                        () => Navigator.popUntil(
                              context,
                              ModalRoute.withName(Routes.layout),
                            ),
                    icon: rightIcon!,
                    padding: rightPadding,
                  ),
              ],
            ),
          ),
          buttonProps != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const AppDivider(mt: 12),
                    Container(
                      padding: const EdgeInsets.only(top: 12),
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 19, right: 19, top: 14, bottom: 28),
                        child: MainButton(
                          onTap: !buttonProps!.disabled
                              ? buttonProps!.onTap
                              : () {},
                          btnText: buttonProps!.text,
                          bgColor:
                              buttonProps!.disabled ? mediumGrey : primaryColor,
                        ),
                      ),
                    ),
                  ],
                )
              : Container()
        ],
      ),
    );
  }
}
