import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class MorePage extends StatelessWidget {
  const MorePage({super.key});

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: IconButton(onPressed: signUserOut, icon: Icon(Icons.logout)));
  }
}
