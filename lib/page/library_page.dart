import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  postData() async {
    try {
      var response = await http.post(
          Uri.parse(
              "https://auth.mangadex.org/realms/mangadex/protocol/openid-connect/token"),
          body: {
            "grant_type": "password",
            "username": "MrCrunchies",
            "password": "Sdjj2015",
            "client_id":
                "personal-client-b2420d84-76e1-4feb-9b92-ac7e582d432b-baef788c",
            "client_secret": "6TlYnf0oSNQQ2UObZIYRVOhIw2rPIhk0",
          });
      final body = response.body;
      final json = jsonDecode(body);
      final accessToken = json['access_token'];
      final refreshToken = json['refresh_token'];
      print("ACCESS TOKEN: " + accessToken);
      print("REFRESH TOKEN: " + refreshToken);
    } catch (e) {
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
        body: Padding(
          padding: EdgeInsets.all(5.0),
          child: GridView.builder(
              addAutomaticKeepAlives: true,
              shrinkWrap: false,
              itemCount: 10,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                childAspectRatio: 1 / 1.75,
              ),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: buildImage(),
                );
              }),
        ));
  }

  Widget buildImage() {
    return Column(
      children: [
        Container(
          height: 270,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                  child: Text(
                "One Piece",
                style: TextStyle(fontSize: 12),
              ))
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
