import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
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
  bool isLoading = true;

  var hash = "";
  var baseUrl = "";

  void onLoad() async {
    try {
      final id = widget.chapterId;
      const String url = 'https://api.mangadex.org';
      final response = await http.get(Uri.parse('$url/at-home/server/$id'));
      final responseData = jsonDecode(response.body);
      setState(() {
        dataSaver = responseData["chapter"]["dataSaver"];
        hash = responseData["chapter"]["hash"];
        baseUrl = responseData["baseUrl"];
      });
    } catch (e) {
      print(e);
    }

    try {
      pages.length = dataSaver.length;
      for (int i = 0; i < dataSaver.length; i++) {
        var fileName = dataSaver[i];
        var url = "$baseUrl/data-saver/$hash/$fileName";
        pages[i] = url;
      }
    } catch (e) {
      print(e);
    }
  }

  Future loadData() async {
    setState(() {
      isLoading = true;
    });
    await Future.wait(
        pages.map((imageUrl) => cacheImage(context, imageUrl)).toList());
    setState(() {
      isLoading = false;
    });
  }

  Future cacheImage(BuildContext context, String imageUrl) =>
      precacheImage(CachedNetworkImageProvider(imageUrl), context);

  @override
  void initState() {
    super.initState();
    onLoad();
    WidgetsBinding.instance.addPostFrameCallback((_) => loadData());
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          :ListView.builder(
          itemCount: pages.length,
          itemBuilder: (context, index) {
            final imageUrl = pages[index];
            return buildImage(imageUrl);
          }),
    );
  }

  Widget buildImage(String imageUrl) {
    return Center(
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (BuildContext context, String url) =>  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [CircularProgressIndicator(color: Theme.of(context).colorScheme.tertiary,), SizedBox(height: double.maxFinite,)]),
        ),
        errorWidget: (BuildContext context, String url, dynamic error) => const Icon(Icons.error),
      ),
    );
  }
}
