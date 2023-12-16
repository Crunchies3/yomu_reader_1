import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  postData() async {
    try{
      var response = await http.post(
          Uri.parse("https://auth.mangadex.org/realms/mangadex/protocol/openid-connect/token"),
          body: {
            "grant_type":"password",
            "username": "MrCrunchies",
            "password":"Sdjj2015",
            "client_id":"personal-client-b2420d84-76e1-4feb-9b92-ac7e582d432b-baef788c",
            "client_secret":"6TlYnf0oSNQQ2UObZIYRVOhIw2rPIhk0",
          }
      );
      final body = response.body;
      final json = jsonDecode(body);
      final accessToken = json['access_token'];
      final refreshToken = json['refresh_token'];
      print("ACCESS TOKEN: " + accessToken);
      print("REFRESH TOKEN: " + refreshToken);

    } catch(e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text("Library"),
      ),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Hello"),
          IconButton(onPressed: postData, icon: Icon(Icons.post_add))
        ],
      )),
    );
  }
}
