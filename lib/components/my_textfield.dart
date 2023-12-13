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
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.background),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
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
