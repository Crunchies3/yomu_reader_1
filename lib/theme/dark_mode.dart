import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Color(hexColor('3b51248')),
    primary: Color(212328),
    secondary: Colors.grey[300]!,
    tertiary: Colors.deepOrange,
    inversePrimary: Colors.grey[600]!,
  ),
);

int hexColor(String color) {
  String newColor = '0xff' + color;
  newColor = newColor.replaceAll('#', '');
  int finalColor = int.parse(newColor);
  return finalColor;
}


