import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black), // ✅ Replaced headline6
      bodyMedium: TextStyle(fontSize: 16, color: Colors.black87), // ✅ Replaced bodyText2
    ),
    buttonTheme: const ButtonThemeData(buttonColor: Colors.blue, textTheme: ButtonTextTheme.primary),
  );
}
