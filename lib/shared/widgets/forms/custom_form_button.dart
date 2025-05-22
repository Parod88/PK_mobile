import 'package:flutter/material.dart';

class CustomFormButton extends StatelessWidget {
  final String text;
  final bool disabled;
  final Function() onPressed;

  const CustomFormButton(
      {super.key,
      required this.text,
      this.disabled = false,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: disabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: disabled ? Colors.grey : Colors.black,
          minimumSize: const Size(double.infinity, 20),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ));
  }
}
