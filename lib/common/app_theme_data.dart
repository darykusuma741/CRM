import 'package:flutter/material.dart';

class AppThemeData {
  static ThemeData get primary => ThemeData(
        fontFamily: 'Lexend',
        textTheme: _TextThemes.primaryTextTheme,
        primaryTextTheme: _TextThemes.primaryTextTheme,
        textSelectionTheme: TextSelectionThemeData(),
      );
}

class _TextThemes {
  static final TextStyle _textTheme = TextStyle(fontFamily: 'Lexend', color: Colors.white, fontSize: 5.0, letterSpacing: 0.0);

  static TextTheme primaryTextTheme = TextTheme(
    bodySmall: _textTheme,
    bodyLarge: _textTheme,
    bodyMedium: _textTheme,
    displayLarge: _textTheme,
  );
}
