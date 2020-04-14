import 'package:flutter/material.dart';

class LightTheme {
  static final colorSchemeLight = ColorScheme.light(
      primary: Color.fromRGBO(0, 145, 56, 1),
      secondary: Color.fromRGBO(0, 208, 79, 1),
      primaryVariant: Color.fromRGBO(0, 110, 42, 1),
      secondaryVariant: Color.fromRGBO(0, 184, 70, 1),
      surface: Color.fromRGBO(0, 131, 39, 1),
      background: Colors.white,
      brightness: Brightness.dark,
      error: Color.fromRGBO(171, 0, 0, 1),
      onBackground: Color.fromRGBO(26, 26, 26, 1),
      onError: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Color.fromRGBO(255, 255, 255, 0.8),
      onSurface: Colors.white);

  static final themeData = ThemeData(
    accentTextTheme: TextTheme(
      body2: TextStyle(
        decoration: TextDecoration.underline,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    ),
    textTheme: TextTheme(
        body1: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        body2: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        subhead: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        title: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w400,
            color: Colors.white,
            height: 1),
        headline: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            height: 1),
        button: TextStyle(
            fontSize: 16, color: Colors.white, fontWeight: FontWeight.w400),
        display1: TextStyle(
            fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400),
        display2: TextStyle(
            fontSize: 22, color: Colors.white, fontWeight: FontWeight.w400),
        display3: TextStyle(
            fontSize: 26, color: Colors.white, fontWeight: FontWeight.w800),
        caption: TextStyle(
            fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600)),
    colorScheme: colorSchemeLight,
    scaffoldBackgroundColor: Colors.transparent,
    splashColor: Colors.transparent,
    primaryColor: Color(0xFF009138),
    accentColor: Color(0xFF005532),
    highlightColor: Color(0xFF005631),
    buttonColor: Color(0xFF025D22),
    secondaryHeaderColor: Color(0xFF0092D7),
    primarySwatch: Colors.green,
    disabledColor: Color(0xFFa0a0a0),
  );
}
