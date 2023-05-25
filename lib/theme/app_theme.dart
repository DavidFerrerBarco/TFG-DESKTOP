import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF0C9860);
  static const Color secondary = Color(0xFF008B76);
  static const Color backgroundGreen = Color.fromARGB(200, 56, 255, 175);
  static const Color shadowGreen = Color.fromARGB(255, 44, 184, 128);
  static const Color redColor = Color.fromARGB(255, 167, 28, 28);
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    //Color primario
    primaryColor: primary,
    // AppBar Theme
    appBarTheme: const AppBarTheme(
      color: primary,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontSize: 40,
        color: Colors.white,
        decoration: TextDecoration.none,
      ),
      bodyMedium: TextStyle(
        fontSize: 25,
        color: Colors.white,
        decoration: TextDecoration.none,
      ),
      titleSmall: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      labelSmall: TextStyle(
        fontSize: 15,
      ),
      labelMedium: TextStyle(
        fontSize: 19,
        color: Colors.black,
      ),
      labelLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        fontSize: 30,
        color: Colors.black
      )
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        shape: const StadiumBorder(),
        shadowColor: shadowGreen,
        elevation: 6,
      ),
    ),

    inputDecorationTheme: const InputDecorationTheme(
      floatingLabelStyle: TextStyle(color: primary),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primary),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primary),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: primary, style: BorderStyle.solid),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      fillColor: Colors.white,
    ),
  );
}
