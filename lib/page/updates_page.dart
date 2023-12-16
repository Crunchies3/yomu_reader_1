import 'package:flutter/material.dart';
class UpdatesPage extends StatelessWidget {
  const UpdatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text("Updates"),
      ),
        body: Center(child: Text("Mabuang nako")));
  }
}

