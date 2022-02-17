import 'package:flutter/material.dart';

class AppTextStyles {
  AppTextStyles._();

  static const labelStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w700,
    fontSize: 40,
  );

  static const unselectedLabelStyle = TextStyle(
    color: Colors.black87,
    fontWeight: FontWeight.w600,
    fontSize: 24,
  );

  static const movieNameTextStyle = TextStyle(
    fontSize: 45,
    fontWeight: FontWeight.bold,
  );

  static const movieDetails = TextStyle(
    height: 1.5,
    fontSize: 20,
  );

  static const bookButtonTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.1,
  );

  static const movieDescriptionStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w300,
  );

  static const infoTitleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );

  static const infoContentStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );
}
