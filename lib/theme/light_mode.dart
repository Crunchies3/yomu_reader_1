import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.grey[300]!,
    primary: Colors.deepOrange,
    secondary: Colors.grey[900]!,
    inversePrimary: Colors.grey[900]!,
  ),
  textTheme: ThemeData.light().textTheme.apply(
      bodyColor: Colors.grey[700],
      displayColor: Colors.black
  ),
);
