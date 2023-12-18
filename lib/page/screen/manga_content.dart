import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class MangaContent extends StatefulWidget {
  final String mangaTitle;
  final String chapterId;
  final String chapterTitle;

  const MangaContent(
      {super.key,
      required this.chapterId,
      required this.mangaTitle,
      required this.chapterTitle});

  @override
  State<MangaContent> createState() => _MangaContentState();
}

class _MangaContentState extends State<MangaContent> {

  List<dynamic> dataSaver = [];
  List<dynamic> pages = [""];

  var hash = "";
  var baseUrl = "";



  void onLoad() async {

    try{
      final id = widget.chapterId;
      const String url = 'https://api.mangadex.org';
      final response = await http.get(
        Uri.parse('$url/at-home/server/$id')
      );
      final responseData = jsonDecode(response.body);
      setState(() {
        dataSaver = responseData["chapter"]["dataSaver"];
        hash = responseData["chapter"]["hash"];
        baseUrl = responseData["baseUrl"];
      });
    } catch(e) {
      print(e);
    }

    try {
      pages.length = dataSaver.length;
      for(int i = 0; i < dataSaver.length; i++){
        var fileName = dataSaver[i];
        var url = "$baseUrl/data-saver/$hash/$fileName";
        pages[i] = url;
      }
    } catch(e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    onLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.mangaTitle),
            SizedBox(
              height: 2,
            ),
            Text(
              "Chapter " + widget.chapterTitle,
              style: TextStyle(fontSize: 13, color: Colors.grey[400]),
            ),
          ],
        ),
      ),
      body: ListView.builder(
          itemCount: pages.length,
          itemBuilder: (context, index) {
        return Image.network(pages[index],
        fit: BoxFit.fitWidth,
        );
      }),
    );
  }
}
