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
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.hasData) {
            Map<String, dynamic>? user =
                snapshot.data!.data() as Map<String, dynamic>?;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Divider(
                    height: 20,
                    thickness: 1,
                    endIndent: 0,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(24)),
                    padding: EdgeInsets.all(25),
                    child: Icon(
                      Icons.person,
                      size: 64,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    user!['username'],
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(user['email'],
                    style: TextStyle(
                      color: Colors.grey[600]
                    ),
                  ),

                  SizedBox(
                    height: 25,
                  ),

                  Divider(
                    height: 20,
                    thickness: 1,
                    endIndent: 0,
                    color: Theme.of(context).colorScheme.secondary,
                  ),

                  ListTile(
                    leading: Icon(Icons.edit, color: Theme.of(context).colorScheme.tertiary),
                    title: Text("Edit Username"),
                    onTap: () {

                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.info_outline, color: Theme.of(context).colorScheme.tertiary),
                    title: Text("About"),
                    onTap: () {

                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout, color: Theme.of(context).colorScheme.tertiary,),
                    title: Text("Logout"),
                    onTap: () {
                      signUserOut();
                    },
                  ),
                ],
              ),
            );
          } else {
            return Text("No Data");
          }
        },
      ),
    );
  }
}
