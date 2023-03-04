import 'package:flutter/material.dart';

class Themes {
  static ThemeData customDarkTheme = ThemeData.dark().copyWith(
    elevatedButtonTheme: const ElevatedButtonThemeData(style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.green)) ,),
    inputDecorationTheme: const InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: Colors.grey, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: Colors.green, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: Colors.red, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: Colors.red, width: 2),
      ),
    )
     );
  static ThemeData customLightTheme = ThemeData.light().copyWith(
    elevatedButtonTheme: const ElevatedButtonThemeData(style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red))  ),
    inputDecorationTheme: const InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: Colors.grey, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: Colors.green, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: Colors.red, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: Colors.red, width: 2),
      ),
    )
    
  );
 
}

