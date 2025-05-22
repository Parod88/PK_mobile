import 'package:flutter/material.dart';
import 'package:passkey/shared/styles/styles.dart';

class AppDivider extends StatelessWidget {
  final Color color;
  final double thickness;
  final double mt;
  final double mb;

  const AppDivider({
    super.key,
    this.color = clearGrey,
    this.thickness = 1,
    this.mt = 0,
    this.mb = 0,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: mt, bottom: mb),
      color: color,
      height: thickness,
      width: double.infinity,
    );
  }
}
