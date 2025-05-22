import 'package:flutter/material.dart';
import 'package:passkey/shared/widgets/texts/app_text.dart';

class ScreenLayout extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final double paddingTop;
  final double paddingBot;
  final double paddingRight;
  final double paddingLeft;
  final double pl;
  final double pr;
  final double pt;
  final double pb;
  final bool useBackgroundImg;
  final String? bgImage;
  final bool useAppBar;
  final String title;
  final bool dismissKeyboard;

  const ScreenLayout({
    super.key,
    required this.child,
    this.backgroundColor = Colors.white,
    this.paddingBot = 0,
    this.paddingTop = 0,
    this.paddingLeft = 0,
    this.paddingRight = 0,
    this.useBackgroundImg = false,
    this.bgImage,
    this.useAppBar = false,
    this.title = '',
    this.dismissKeyboard = true,
    this.pl = 0,
    this.pr = 0,
    this.pt = 0,
    this.pb = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      appBar: useAppBar
          ? AppBar(
              title: AppText(text: title),
              backgroundColor: Colors.white,
              titleTextStyle:
                  const TextStyle(color: Colors.black, fontSize: 20),
            )
          : null,
      body: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        child: GestureDetector(
          onTap:
              dismissKeyboard ? () => FocusScope.of(context).unfocus() : null,
          child: Padding(
            padding: EdgeInsets.only(
              top: paddingTop,
              bottom: paddingBot,
              left: paddingLeft,
              right: paddingRight,
            ),
            child: useBackgroundImg
                ? Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: pl, right: pr, top: pt),
                        child: child,
                      ),
                    ],
                  )
                : Padding(
                    padding: EdgeInsets.only(left: pl, right: pr, top: pt),
                    child: child,
                  ),
          ),
        ),
      ),
    );
  }
}
