import 'package:flutter/material.dart';
class BrowsePage extends StatelessWidget {
  const BrowsePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Naunsa namane"));
  }
}

class BrowsePageAppbar extends StatelessWidget {
  const BrowsePageAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: Text("Browse"),
    );
  }
}

