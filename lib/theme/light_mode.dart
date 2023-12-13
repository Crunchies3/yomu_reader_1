import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.white,
    primary: Colors.deepOrange,
    secondary: Colors.grey[400]!,
    inversePrimary: Colors.grey[900]!,
  ),
  textTheme: ThemeData.light().textTheme.apply(
      bodyColor: Colors.grey[700],
      displayColor: Colors.black
  ),
);
