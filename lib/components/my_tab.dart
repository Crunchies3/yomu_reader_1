import 'package:flutter/material.dart';

class MyTab extends StatelessWidget {
  final IconData icon;
  final String text;
  const MyTab({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(
            width: 5,
          ),
          Text(
            text,
            style: TextStyle(
                color:
                Theme.of(context).colorScheme.inversePrimary),
          )
        ],
      ),
    );
  }
}
