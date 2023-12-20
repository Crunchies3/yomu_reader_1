import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../my_classes/services/firestore.dart';
class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {

  final FireStoreService fireStoreService = FireStoreService();

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot<Object?>>(
        future: fireStoreService.getCurrentUserDetails(),
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.hasData) {
            Map<String, dynamic>? user = snapshot.data!.data() as Map<String, dynamic>?;
            return Column(
              children: [
                Text(user!['email']),
                Text(user['username']),
                Center(child: IconButton(onPressed: signUserOut, icon: Icon(Icons.logout)))
              ],
            );
          } else {
            return Text("No Data");
          }
        },
      ),
    );
  }
}
