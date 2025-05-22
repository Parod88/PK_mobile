import 'package:flutter/material.dart';

// Text Styles
const signUpTitleStyle = TextStyle(
  color: Colors.white,
  fontSize: 24,
  fontWeight: FontWeight.w700,
  fontFamily: 'OpenSans',
  height: 1.5,
  letterSpacing: -0.456,
);

const titleStyle = TextStyle(
    color: Colors.black,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    fontFamily: 'OpenSans',
    height: 1.5,
    letterSpacing: -0.456);

const messageStyle = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: 'OpenSans',
    height: 1.5,
    letterSpacing: -0.304);

// Theme Color Styles
const primaryColor = Color(0xFF2554FB);
const softTextColor = Color(0xFF828282);
const darkTextColor = Color(0xFF282828);
const clearGrey = Color(0xFFE5E5E6);
const mediumGrey = Color(0xFFC6C6C8);
const neutralGrey = Color(0xFF494949);
const validationGreen = Color(0xFF3e9528);

// Theme Shadows
final defaultShadow = [
  BoxShadow(
    color: Colors.black.withOpacity(0.00),
    offset: const Offset(0, 35),
    blurRadius: 10,
  ),
  BoxShadow(
    color: Colors.black.withOpacity(0.01),
    offset: const Offset(0, 23),
    blurRadius: 9,
  ),
  BoxShadow(
    color: Colors.black.withOpacity(0.02),
    offset: const Offset(0, 13),
    blurRadius: 8,
  ),
  BoxShadow(
    color: Colors.black.withOpacity(0.03),
    offset: const Offset(0, 6),
    blurRadius: 6,
  ),
  BoxShadow(
    color: Colors.black.withOpacity(0.04),
    offset: const Offset(0, 1),
    blurRadius: 3,
  ),
];
