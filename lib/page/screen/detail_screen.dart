import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yomu_reader_1/components/description_text.dart';
import 'package:http/http.dart' as http;

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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getChapterId());
    onLoad();
  }

  void getChapterId() async {
    mangaChapter[0] = "";
  }

  void onLoad() async {
    try {

      Map<String, String> order = {
        "volume": "asc",
        "chapter": "asc"
      };

      List<dynamic> language = ["en",];
      Map<String, dynamic> finalOrderQuery = {};
      order.forEach((key, value) {
        finalOrderQuery["order[$key]"] = value;
      });

      final id = widget.id;
      const String baseUrl = 'https://api.mangadex.org';
      final response = await http.get(
        Uri.parse('$baseUrl/manga/$id/feed').replace(
            queryParameters: {
              ...{
                "limit": "500",
                "translatedLanguage[]":language,
                "includeEmptyPages": "0"
              },
              ...finalOrderQuery
            }
        ),
        headers: {'Content-Type': 'application/json'},
      );
      final responseData = jsonDecode(response.body);
      final mangaList = responseData['data'] as List<dynamic>;
      setState(() {
        mangaChapter = mangaList;
      });
      numberOfAvailableChapter = mangaChapter.length;
      revmangaChapter = mangaChapter.reversed.toList();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
        },
        label: Text('Start', style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
        icon:  Icon(Icons.play_arrow, color: Theme.of(context).colorScheme.inversePrimary),
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
                        child: Image.network(
                          widget.image,
                          fit: BoxFit.fill,
                        ),
                      ),
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
                                style: TextStyle(fontSize: 12,
                                  color: Colors.grey
                                ),
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
                                  style: TextStyle(fontSize: 12,
                                  color: Colors.grey),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: FilledButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    Theme.of(context).colorScheme.primary),
                              ),
                              onPressed: () {},
                              child: Padding(
                                padding: EdgeInsets.all(6),
                                child: Column(children: [
                                  Icon(
                                    Icons.favorite_border,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
                                  ),
                                  Text("Add to library",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12)),
                                ]),
                              ))),
                    ],
                  ),
                  SizedBox(
                    height: 10,
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
                  ListView.builder(

                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: mangaChapter.length,
                    itemBuilder: (context, index) {

                      final chapter = revmangaChapter[index];
                      final chapterId = chapter["id"];
                      var publishedAt = chapter["attributes"]["publishAt"];
                      var chapterTitle;
                      if(chapter["attributes"]["title"] == null) {
                        chapterTitle = chapter["attributes"]["chapter"];
                      }else {
                        chapterTitle = chapter["attributes"]["chapter"] + " " + chapter["attributes"]["title"];
                      }


                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        onTap: () {},
                        title: Text("Chapter $chapterTitle"),
                        subtitle: Text(publishedAt.substring(0,10), style: TextStyle(
                          fontSize: 11, color: Colors.grey[400]
                        ),),
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
