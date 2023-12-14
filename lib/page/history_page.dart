import 'package:flutter/material.dart';
class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Hays"));
  }
}

class HistoryPageAppbar extends StatelessWidget implements PreferredSize{
  const HistoryPageAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: Text("History"),
    );
  }

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

