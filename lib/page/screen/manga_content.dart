import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yomu_reader_1/my_classes/services/firestore.dart';
import 'package:yomu_reader_1/library/globals.dart' as globals;

class MangaContent extends StatefulWidget {
  final String mangaId;
  final String mangaTitle;
  final List<dynamic> mangaChapters;
  final int index;
  final String author;
  final String status;
  final String desc;
  final String image;

  const MangaContent(
      {super.key,
      required this.mangaChapters,
      required this.mangaTitle,
      required this.index,
      required this.mangaId,
      required this.author,
      required this.status,
      required this.desc, required this.image});

  @override
  State<MangaContent> createState() => _MangaContentState();
}

class _MangaContentState extends State<MangaContent> {
  List<dynamic> dataSaver = [];
  List<dynamic> pages = [""];
  bool isLoading = true;
  int currentChap = 0;
  String chapterTitle = "";

  var hash = "";
  var baseUrl = "";

  void onLoad() async {
    currentChap = widget.index;
    chapterTitle;
    if (widget.mangaChapters[currentChap]["attributes"]["title"] == null) {
      chapterTitle = widget.mangaChapters[currentChap]["attributes"]["chapter"];
    } else {
      chapterTitle = widget.mangaChapters[currentChap]["attributes"]
              ["chapter"] +
          " " +
          widget.mangaChapters[currentChap]["attributes"]["title"];
    }

    try {
      final id = widget.mangaChapters[currentChap]["id"];
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

  void refreshState(index) async {
    currentChap = index;
    chapterTitle;
    if (widget.mangaChapters[currentChap]["attributes"]["title"] == null) {
      chapterTitle = widget.mangaChapters[currentChap]["attributes"]["chapter"];
    } else {
      chapterTitle = widget.mangaChapters[currentChap]["attributes"]
              ["chapter"] +
          " " +
          widget.mangaChapters[currentChap]["attributes"]["title"];
    }

    try {
      final id = widget.mangaChapters[currentChap]["id"];
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
    WidgetsBinding.instance.addPostFrameCallback((_) => loadData());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.tertiary,
            ))
          : NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, innerBoxScrolled) => [
                SliverAppBar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  snap: true,
                  floating: true,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.mangaTitle),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        "Chapter " + chapterTitle,
                        style: TextStyle(fontSize: 13, color: Colors.grey[400]),
                      ),
                    ],
                  ),
                )
              ],
              body: ListView.builder(
                  itemCount: pages.length,
                  itemBuilder: (context, index) {
                    final imageUrl = pages[index];
                    return buildImage(imageUrl);
                  }),
            ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Visibility(
              visible: isFirst(),
              child: FloatingActionButton(
                onPressed: () {
                  final FireStoreService fireStoreService =
                  FireStoreService();
                  setState(() {
                    setState(() {
                      var index = ++currentChap;
                      refreshState(index);
                      fireStoreService.addMangaToHistory(
                        globals.email,
                        widget.mangaId,
                        index,
                        widget.mangaChapters,
                        widget.author,
                        widget.desc,
                        widget.status,
                        widget.mangaTitle,
                        chapterTitle,
                        widget.image
                      );
                    });
                  });
                },
                child: Icon(
                  Icons.skip_previous,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
            Expanded(child: Container()),
            Visibility(
              visible: isLatest(),
              child: FloatingActionButton(
                  onPressed: () {
                    final FireStoreService fireStoreService =
                        FireStoreService();
                    setState(() {
                      var index = --currentChap;
                      refreshState(index);

                      fireStoreService.addMangaToHistory(
                        globals.email,
                        widget.mangaId,
                        index,
                        widget.mangaChapters,
                        widget.author,
                        widget.desc,
                        widget.status,
                        widget.mangaTitle,
                        chapterTitle,
                        widget.image
                      );
                    });
                  },
                  child: Icon(
                    Icons.skip_next,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  )),
            )
          ],
        ),
      ),
    );
  }

  bool isLatest() {
    if (currentChap == 0)
      return false;
    else
      return true;
  }

  bool isFirst() {
    if (currentChap == widget.mangaChapters.length - 1)
      return false;
    else
      return true;
  }

  Widget buildImage(String imageUrl) {
    return Center(
      child: CachedNetworkImage(
        key: UniqueKey(),
        imageUrl: imageUrl,
        fit: BoxFit.fitWidth,
        placeholder: (BuildContext context, String url) => Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.tertiary,
                  )
                ]),
          ),
        ),
        errorWidget: (BuildContext context, String url, dynamic error) =>
            const Icon(Icons.error),
      ),
    );
  }
}
