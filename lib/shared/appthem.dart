import 'package:flutter/material.dart';

class Appthem {
  static const Color primary = Color(0xFF3598DB);

  static const Color black = Color(0xFF363636);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFFC8C9CB);
  static const Color red = Color(0xFFEC4B4B);
  static const Color green = Color(0xFF61E757);
  static ThemeData lighappthem = ThemeData(
    primaryColor: primary,
    scaffoldBackgroundColor: white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      centerTitle: true,
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: white,
      shape: CircleBorder(side: BorderSide(color: white, width: 4)),
    ),
    textTheme: TextTheme(
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: primary,
      ),
      titleSmall: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: black,
      ),
    ),
  );
}
