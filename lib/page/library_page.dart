import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Hello"));
  }
}

class LibraryAppbar extends StatelessWidget {
  const LibraryAppbar({super.key});

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: Text("Library"),
    );
  }
}
