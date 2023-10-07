import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData theme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Color.fromARGB(9, 6, 96, 1),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromRGBO(9, 6, 96, 1),
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color.fromRGBO(148, 165, 223, 0.875),
    ),
  );
}
