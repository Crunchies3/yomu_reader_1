import 'package:flutter/material.dart';
class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Hays"));
  }
}

class HistoryPageAppbar extends StatelessWidget {
  const HistoryPageAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: Text("History"),
    );
  }
}

