import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  const MyTextField({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: Theme.of(context).colorScheme.inversePrimary,
      cursorWidth: 1,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10.0),
        filled: true,
        fillColor: Theme.of(context).colorScheme.secondary,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(9)
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary
        )
      ),
      obscureText: obscureText,
    );
  }
}
