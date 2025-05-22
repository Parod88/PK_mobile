import 'package:flutter/material.dart';
import 'package:passkey/shared/utils/strings.dart';
import 'package:passkey/shared/widgets/forms/custom_text_field.dart';
import 'package:passkey/shared/widgets/texts/app_text.dart';

class ProfileInput extends StatelessWidget {
  final String title;
  final String? hintText;
  final TextEditingController controller;
  final bool isEmail;
  final bool isObscure;
  final String? Function(String?) validator;

  const ProfileInput(
      {super.key,
      required this.title,
      this.hintText,
      required this.controller,
      this.isEmail = false,
      this.isObscure = false,
      this.validator = _defaultValidator});

  static String? _defaultValidator(String? value) {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(text: title.capitalize(), size: 14, letterSpacing: -0.26),
        const SizedBox(height: 12),
        CustomTextField(
          mb: 12,
          controller: controller,
          showLabel: false,
          inputType: !isEmail ? TextInputType.text : TextInputType.emailAddress,
          name: "name",
          toggleObscure: false,
          enableValidator: isEmail ? true : false,
          validator: validator,
          hintText: hintText,
          obscureText: isObscure,
        ),
      ],
    );
  }
}
