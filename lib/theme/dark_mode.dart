import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.grey[900]!,
    primary: Colors.deepOrange,
    secondary: Colors.grey[300]!,
    inversePrimary: Colors.grey[600]!,
  ),
  textTheme: ThemeData.dark().textTheme.apply(
    bodyColor: Colors.grey[300]!,
    displayColor: Colors.white,
  ),
);
