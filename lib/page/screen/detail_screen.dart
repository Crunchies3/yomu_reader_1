import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yomu_reader_1/components/description_text.dart';
import 'package:http/http.dart' as http;
import 'package:yomu_reader_1/my_classes/services/firestore.dart';
import 'package:yomu_reader_1/page/screen/manga_content.dart';
import 'package:yomu_reader_1/library/globals.dart' as globals;

class DetailScreen extends StatefulWidget {
  final String title;
  final String id;
  final String author;
  final String desc;
  final String status;
  final image;

  const DetailScreen(
      {super.key,
      required this.title,
      required this.id,
      required this.author,
      required this.desc,
      required this.status,
      required this.image});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List<dynamic> mangaChapter = [];
  List<dynamic> revmangaChapter = [];
  var numberOfAvailableChapter = 0;
  bool isLoading = true;
  bool isAddedToLibrary = false;
  bool nagLoading = true;
  var currChapter = 0;
  bool isInHistory = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getChapterId());
    onLoad();
    checKIfInLibrary();
    checkIfInHistory();
  }

  checkIfInHistory() async {
    isInHistory = await fireStoreService.isInHistory(widget.id);
  }

  checKIfInLibrary() async {
    setState(() {
      nagLoading = true;
    });
    isAddedToLibrary = await fireStoreService.isInLibrary(widget.id);
    setState(() {
      nagLoading = false;
    });
  }

  void getChapterId() async {
    mangaChapter[0] = "";
  }

  void onLoad() async {
    try {
      setState(() {
        isLoading = true;
      });

      Map<String, String> order = {"volume": "asc", "chapter": "asc"};

      List<dynamic> language = [
        "en",
      ];
      Map<String, dynamic> finalOrderQuery = {};
      order.forEach((key, value) {
        finalOrderQuery["order[$key]"] = value;
      });

      final id = widget.id;
      const String baseUrl = 'https://api.mangadex.org';
      final response = await http.get(
        Uri.parse('$baseUrl/manga/$id/feed').replace(queryParameters: {
          ...{
            "limit": "500",
            "translatedLanguage[]": language,
            "includeEmptyPages": "0"
          },
          ...finalOrderQuery
        }),
        headers: {'Content-Type': 'application/json'},
      );
      final responseData = jsonDecode(response.body);
      final mangaList = responseData['data'] as List<dynamic>;
      setState(() {
        mangaChapter = mangaList;
      });
      numberOfAvailableChapter = mangaChapter.length;
      revmangaChapter = mangaChapter.reversed.toList();



      if(isInHistory) {
        setState(() async {
          currChapter =  await fireStoreService.gettCurrChapter(widget.id);

        });
      } else {
        setState(() {
          currChapter = revmangaChapter.length - 1;
        });
      }
    } catch (e) {
      print(e);
    }

    setState(() {
      isLoading = false;
    });
  }

  final FireStoreService fireStoreService = FireStoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final FireStoreService fireStoreService = FireStoreService();

          final chapter = revmangaChapter[currChapter];
          var chapterTitle;
          if (chapter["attributes"]["title"] == null) {
            chapterTitle = chapter["attributes"]["chapter"];
          } else {
            chapterTitle = chapter["attributes"]["chapter"] +
                " " +
                chapter["attributes"]["title"];
          }

          fireStoreService.addMangaToHistory(
              globals.email,
              widget.id,
              currChapter,
              revmangaChapter,
              widget.author,
              widget.desc,
              widget.status,
              widget.title,
              chapterTitle,
              widget.image);

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MangaContent(
                        mangaId: widget.id,
                        mangaTitle: widget.title,
                        mangaChapters: revmangaChapter,
                        index: currChapter,
                        author: widget.author,
                        status: widget.status,
                        desc: widget.desc,
                        image: widget.image,
                      )));
        },
        label: isInHistory
            ? Text(
                'Resume',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary),
              )
            : Text(
                'Start',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
        icon: Icon(Icons.play_arrow,
            color: Theme.of(context).colorScheme.inversePrimary),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
      ),
      body: Scrollbar(
        interactive: true,
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          height: 150,
                          width: 100,
                          color: Colors.grey,
                          child: CachedNetworkImage(
                            imageUrl: widget.image,
                            fit: BoxFit.fill,
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: TextStyle(fontSize: 22),
                            ),
                            Row(children: [
                              const Icon(
                                CupertinoIcons.person,
                                size: 12,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.author,
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ]),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(
                                  CupertinoIcons.clock,
                                  size: 12,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  widget.status,
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: StreamBuilder<
                              DocumentSnapshot<Map<String, dynamic>>>(
                        stream: fireStoreService.getCurrentChap(widget.id),
                        builder: (context, snapshot) {
                          Map<String, dynamic>? manga =
                              snapshot.data!.data() as Map<String, dynamic>?;
                          var naasHistory = false;

                          if (snapshot.hasData) {
                            naasHistory = true;
                          } else {
                            naasHistory = false;
                          }

                          return nagLoading
                              ? Center(
                                  child: Column(
                                  children: [
                                    SizedBox(
                                      height: 150,
                                    ),
                                    CircularProgressIndicator(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                    ),
                                  ],
                                ))
                              : FilledButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<
                                            Color>(
                                        Theme.of(context).colorScheme.primary),
                                  ),
                                  onPressed: () {
                                    final FireStoreService fireStoreService =
                                        FireStoreService();

                                    if (!isAddedToLibrary) {
                                      fireStoreService.addMangaToLibrary(
                                          globals.email,
                                          widget.id,
                                          naasHistory
                                              ? 0
                                              : manga!['recent_chapter'],
                                          revmangaChapter,
                                          widget.author,
                                          widget.desc,
                                          widget.status,
                                          widget.title,
                                          "",
                                          widget.image);
                                      setState(() {
                                        isAddedToLibrary = true;
                                      });
                                    } else {
                                      fireStoreService.removeMangaFromLibrary(
                                          globals.email, widget.id);
                                      setState(() {
                                        isAddedToLibrary = false;
                                      });
                                    }
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(6),
                                    child: Column(children: [
                                      isAddedToLibrary
                                          ? Icon(
                                              Icons.favorite,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .tertiary,
                                            )
                                          : Icon(
                                              Icons.favorite_border,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .inversePrimary,
                                            ),
                                      isAddedToLibrary
                                          ? Text("Added To Library",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12))
                                          : Text("Add to library",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12)),
                                    ]),
                                  ));
                        },
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                      child: DescriptionText(
                    desc: widget.desc,
                  )),
                  Text(
                    "$numberOfAvailableChapter chapters",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  isLoading
                      ? Center(
                          child: Column(
                          children: [
                            SizedBox(
                              height: 150,
                            ),
                            CircularProgressIndicator(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ],
                        ))
                      : ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: mangaChapter.length,
                          itemBuilder: (context, index) {
                            final chapter = revmangaChapter[index];
                            var publishedAt =
                                chapter["attributes"]["publishAt"];
                            var chapterTitle;
                            if (chapter["attributes"]["title"] == null) {
                              chapterTitle = chapter["attributes"]["chapter"];
                            } else {
                              chapterTitle = chapter["attributes"]["chapter"] +
                                  " " +
                                  chapter["attributes"]["title"];
                            }

                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              onTap: () {
                                final FireStoreService fireStoreService =
                                    FireStoreService();

                                fireStoreService.addMangaToHistory(
                                    globals.email,
                                    widget.id,
                                    index,
                                    revmangaChapter,
                                    widget.author,
                                    widget.desc,
                                    widget.status,
                                    widget.title,
                                    chapterTitle,
                                    widget.image);

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MangaContent(
                                              mangaId: widget.id,
                                              mangaTitle: widget.title,
                                              mangaChapters: revmangaChapter,
                                              index: index,
                                              author: widget.author,
                                              status: widget.status,
                                              desc: widget.desc,
                                              image: widget.image,
                                            )));
                              },
                              title: Text("Chapter $chapterTitle"),
                              subtitle: Text(
                                publishedAt.substring(0, 10),
                                style: TextStyle(
                                    fontSize: 11, color: Colors.grey[400]),
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
