import 'package:flutter/material.dart';
import 'package:passkey/shared/styles/styles.dart';

class SwitchButton extends StatefulWidget {
  final bool selected;
  final bool withMargin;
  final Function()? onTap;
  const SwitchButton({
    super.key,
    this.onTap,
    this.selected = false,
    this.withMargin = true,
  });

  @override
  State<StatefulWidget> createState() => SwitchButtonState();
}

class SwitchButtonState extends State<SwitchButton> {
  late bool _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap != null
          ? () {
              setState(() {
                _selected = !_selected;
                widget.onTap!();
              });
            }
          : null,
      child: Container(
        margin: widget.withMargin ? const EdgeInsets.only(right: 16) : null,
        width: 40,
        height: 24,
        decoration: BoxDecoration(
          color: _selected ? validationGreen : mediumGrey,
          borderRadius: BorderRadius.circular(24.0),
          border: Border.all(
              color: Theme.of(context).colorScheme.surface, width: 2),
        ),
        child: Container(
          alignment: _selected ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 17.0,
            height: 17.0,
            margin: const EdgeInsets.only(left: 2, right: 2),
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
