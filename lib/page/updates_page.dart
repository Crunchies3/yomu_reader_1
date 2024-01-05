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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.notifications_active_sharp,
                size: 70,
                color: Theme.of(context).colorScheme.secondary,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "No updates found",
                style: TextStyle(
                    color:
                    Theme.of(context).colorScheme.secondary),
              ),
            ],
          ),
        )
    );
  }
}
