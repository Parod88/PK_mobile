import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passkey/shared/theme/icons.dart';

class CustomTextField extends StatefulWidget {
  final double mb;
  final TextEditingController controller;
  final String name;
  final String? hintText;
  final bool obscureText;
  final bool toggleObscure;
  final bool showLabel;
  final TextInputType inputType;
  final bool enableValidator;
  final String? Function(String?) validator;

  const CustomTextField({
    super.key,
    this.mb = 20,
    required this.controller,
    required this.name,
    this.hintText,
    this.enableValidator = true,
    this.obscureText = false,
    this.toggleObscure = true,
    this.showLabel = true,
    this.inputType = TextInputType.text,
    this.validator = _defaultValidator,
  });

  static String? _defaultValidator(String? value) {
    return null;
  }

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isLabelVisible = true;
  bool _isObscure = true;
  bool _hasError = false;

  void toggleObscure() {
    if (widget.toggleObscure) {
      setState(() {
        _isObscure = !_isObscure;
      });
    }
  }

  String? validate(val) {
    String? errorText = widget.validator(val);
    if (errorText != null && !_hasError) {
      setState(() => _hasError = true);
    } else if (errorText == null) {
      setState(() => _hasError = false);
    }
    return errorText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: widget.mb),
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUnfocus,
          enabled: true,
          validator: validate,
          controller: widget.controller,
          obscureText: widget.obscureText && _isObscure,
          keyboardType: widget.inputType,
          maxLines: 1,
          textAlign: TextAlign.start,
          style: const TextStyle(fontSize: 16),
          onChanged: (value) {
            if (_isLabelVisible != value.isEmpty) {
              setState(() {
                _isLabelVisible = value.isEmpty;
              });
            }
          },
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            label: _isLabelVisible && widget.showLabel
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      widget.name,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 19,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                : null,
            floatingLabelBehavior: _isLabelVisible
                ? FloatingLabelBehavior.always
                : FloatingLabelBehavior.never,
            floatingLabelAlignment: FloatingLabelAlignment.start,
            isDense: true,
            counterText: "",
            labelStyle: const TextStyle(color: Colors.black, fontSize: 18),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFE5E5E6), width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFE5E5E6), width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFE5E5E6), width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            suffixIcon: widget.obscureText && widget.toggleObscure
                ? InkWell(
                    onTap: toggleObscure,
                    child: Container(
                      padding:
                          const EdgeInsets.only(top: 12, right: 24, bottom: 12),
                      child: SvgPicture.asset(
                        _isObscure ? AppIcons.eyeIcon : AppIcons.eyeFilledIcon,
                      ),
                    ),
                  )
                : null,
            hintText: widget.hintText,
          ),
        ));
  }
}
