import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passkey/shared/styles/styles.dart';
import 'package:passkey/shared/theme/icons.dart';

class CheckModality extends StatefulWidget {
  final String name;
  final bool isFlat;

  const CheckModality({super.key, required this.name, this.isFlat = false});

  @override
  State<CheckModality> createState() => _CheckModalityState();
}

class _CheckModalityState extends State<CheckModality> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: 210,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 26),
      decoration: BoxDecoration(
        color: widget.isFlat ? Colors.white : Colors.transparent,
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset(
              widget.isFlat ? AppIcons.gymIcon : AppIcons.hostalIcon),
          const SizedBox(
            height: 8,
          ),
          Text(
            widget.name,
            style: TextStyle(
              color: widget.isFlat ? primaryColor : Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              height: 1.5,
              letterSpacing: -0.38,
              fontFamily: 'OpenSans',
            ),
          )
        ],
      ),
    );
  }
}
