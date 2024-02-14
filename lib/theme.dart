import 'package:flutter/material.dart';

class GreenDestinyTheme {
  static MaterialColor primarySwatch =
      Colors.green; // Define green as the primary swatch color

  static ThemeData lightThemeData = ThemeData(
    brightness: Brightness.light,
    primarySwatch: primarySwatch,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Roboto', // You can change the font family as needed

    // Define the button theme
    buttonTheme: ButtonThemeData(
      buttonColor: primarySwatch,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),

    // Define the input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      border: InputBorder.none,
      enabledBorder: UnderlineInputBorder(),
    ),
  );

  static ThemeData darkThemeData = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: primarySwatch,
    scaffoldBackgroundColor: Colors.grey[900],
    fontFamily: 'Roboto', // You can change the font family as needed

    // Define the button theme
    buttonTheme: ButtonThemeData(
      buttonColor: primarySwatch,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),

    // Define the input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      border: InputBorder.none,
      enabledBorder: UnderlineInputBorder(),
    ),
  );
}
