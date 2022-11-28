import 'package:flutter/material.dart';

class Themes {
  static ThemeData customDarkTheme = ThemeData.dark().copyWith(
    elevatedButtonTheme: const ElevatedButtonThemeData(style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.green))  )
     );
  static ThemeData customLightTheme = ThemeData.light().copyWith(
    elevatedButtonTheme: const ElevatedButtonThemeData(style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red))  )

  );
}
