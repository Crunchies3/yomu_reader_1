import 'package:flutter/material.dart';
class UpdatesPage extends StatelessWidget {
  const UpdatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Mabuang nako"));
  }
}

class UpdatesPageAppbar extends StatelessWidget {
  const UpdatesPageAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: Text("Updates"),
    );
  }
}

