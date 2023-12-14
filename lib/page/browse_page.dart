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
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          height: 60,
          color: Theme.of(context).colorScheme.primary,
          child: Center(
            child: Row(
              children: [

              ],
            )
          ),
        ),
      ),
      actions: [
        IconButton(onPressed: (){}, icon: Icon(Icons.search)),
        IconButton(onPressed: (){}, icon: Icon(Icons.grid_view_sharp)),
      ],
    );
  }
}

