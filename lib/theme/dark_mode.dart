import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Color(hexColor('#111111')),
    primary: Color(hexColor('#212328')),
    secondary: Color(hexColor('#3d414a')),
    tertiary: Color(hexColor('#ff6740')),
    inversePrimary: Color(hexColor('#ffffff')),
  ),
);

int hexColor(String color) {
  String newColor = '0xff' + color;
  newColor = newColor.replaceAll('#', '');
  int finalColor = int.parse(newColor);
  return finalColor;
}


