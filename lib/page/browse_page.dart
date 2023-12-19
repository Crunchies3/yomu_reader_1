import 'package:flutter/material.dart';
import 'package:yomu_reader_1/page/browse_page/filter_page.dart';
import 'package:yomu_reader_1/page/browse_page/latest_page.dart';
import 'package:yomu_reader_1/page/browse_page/popular_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../components/my_tab.dart';

class BrowsePage extends StatefulWidget {
  const BrowsePage({super.key});

  @override
  State<BrowsePage> createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text("Browse");
  List<dynamic> mangaIds = [];
  List<dynamic> mangaTitles = [];
  List<dynamic> mangaCoversFileName = [];
  List<dynamic> mangaCovers = [];
  List<dynamic> mangaAuthor = [];
  List<dynamic> mangaStatus = [];
  List<dynamic> mangaDescription = [];
  bool isFilterAccessible = false;

  bool isLoading = true;

  onLoad() {
    switch (controller.index) {
      case 0:
        getPopularManga();
        break;
      case 1:
        getLatestManga();
        break;
    }
  }

  onTap() {
    if(isFilterAccessible){
      int index = controller.previousIndex;
      setState(() {
        controller.index=index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
    onLoad();
    controller.addListener(() {
      setState(() {
        onTap();
        onLoad();
      });
    });
  }

  getLatestManga() async {
    try {
      setState(() {
        isLoading = true;
      });
      mangaIds = [];

      Map<String, String> order = {"latestUploadedChapter": "desc"};

      Map<String, dynamic> finalOrderQuery = {};
      order.forEach((key, value) {
        finalOrderQuery["order[$key]"] = value;
      });

      var base_url = "https://api.mangadex.org";
      var included_tag_ids = [];
      var excluded_tag_ids = [];

      var response =
          await http.get(Uri.parse("$base_url/manga").replace(queryParameters: {
        ...{
          "includedTags[]": included_tag_ids,
          "excludedTags[]": excluded_tag_ids,
        },
        ...finalOrderQuery,
      }));

      var data = jsonDecode(response.body)["data"];
      setState(() {
        mangaIds = [for (var manga in data) manga["id"]];
      });
      print(mangaIds);
    } catch (e) {
      print(e);
    }

    try {
      Map<String, String> order = {
        "latestUploadedChapter": "desc",
      };
      Map<String, dynamic> finalOrderQuery = {};
      order.forEach((key, value) {
        finalOrderQuery["order[$key]"] = value;
      });
      mangaTitles = [];
      mangaCoversFileName = [];
      mangaAuthor = [];
      mangaDescription = [];
      mangaStatus = [];
      List<dynamic> include = ["cover_art", "author"];
      const String baseUrl = 'https://api.mangadex.org';
      final response = await http.get(
        Uri.parse('$baseUrl/manga').replace(queryParameters: {
          ...{'ids[]': mangaIds, 'includes[]': include},
          ...finalOrderQuery
        }),
        headers: {'Content-Type': 'application/json'},
      );
      final responseData = jsonDecode(response.body);
      final mangaList = responseData['data'] as List<dynamic>;
      for (var manga in mangaList) {
        final mangaRelation = manga['relationships'] as List<dynamic>;
        final coverArt = mangaRelation
            .firstWhere((relationship) => relationship['type'] == 'cover_art');
        String coverFileName = coverArt["attributes"]["fileName"];
        final authorsAttribute = mangaRelation
            .firstWhere((relationship) => relationship['type'] == 'author');
        String authorNames = authorsAttribute["attributes"]["name"];
        setState(() {
          mangaCoversFileName.add(coverFileName);
          mangaAuthor.add(authorNames);
        });
      }
      setState(() {
        mangaTitles = mangaList.map((manga) {
          if (manga["attributes"]["title"].containsKey("en")) {
            return manga["attributes"]["title"]["en"];
          } else {
            return manga["attributes"]["title"]["ja-ro"];
          }
        }).toList();

        mangaStatus = mangaList.map((manga) {
          return manga["attributes"]["status"];
        }).toList();

        mangaDescription = mangaList.map((manga) {
          return manga["attributes"]["description"]["en"];
        }).toList();
      });
    } catch (e) {
      print(e);
    }

    mangaCovers = [];
    mangaCovers.length = mangaIds.length;
    for (int i = 0; i < mangaIds.length; i++) {
      final mangaId = mangaIds[i];
      final fileName = mangaCoversFileName[i];
      mangaCovers[i] = "https://uploads.mangadex.org/covers/$mangaId/$fileName";
    }

    setState(() {
      isLoading = false;
    });
  }

  getPopularManga() async {
    try {
      setState(() {
        isLoading = true;
      });

      mangaIds = [];
      Map<String, String> order = {
        "followedCount": "desc",
      };

      Map<String, dynamic> finalOrderQuery = {};
      order.forEach((key, value) {
        finalOrderQuery["order[$key]"] = value;
      });

      var base_url = "https://api.mangadex.org";
      var included_tag_ids = [];
      var excluded_tag_ids = [];

      var response =
          await http.get(Uri.parse("$base_url/manga").replace(queryParameters: {
        ...{
          "includedTags[]": included_tag_ids,
          "excludedTags[]": excluded_tag_ids,
        },
        ...finalOrderQuery,
      }));

      var data = jsonDecode(response.body)["data"];
      setState(() {
        mangaIds = [for (var manga in data) manga["id"]];
      });
      print(mangaIds);
    } catch (e) {
      print(e);
    }

    try {
      Map<String, String> order = {
        "followedCount": "desc",
      };
      Map<String, dynamic> finalOrderQuery = {};
      order.forEach((key, value) {
        finalOrderQuery["order[$key]"] = value;
      });
      mangaTitles = [];
      mangaCoversFileName = [];
      mangaAuthor = [];
      mangaDescription = [];
      mangaStatus = [];
      List<dynamic> include = ["cover_art", "author"];
      const String baseUrl = 'https://api.mangadex.org';
      final response = await http.get(
        Uri.parse('$baseUrl/manga').replace(queryParameters: {
          ...{'ids[]': mangaIds, 'includes[]': include},
          ...finalOrderQuery
        }),
        headers: {'Content-Type': 'application/json'},
      );
      final responseData = jsonDecode(response.body);
      final mangaList = responseData['data'] as List<dynamic>;
      for (var manga in mangaList) {
        final mangaRelation = manga['relationships'] as List<dynamic>;
        final coverArt = mangaRelation
            .firstWhere((relationship) => relationship['type'] == 'cover_art');
        String coverFileName = coverArt["attributes"]["fileName"];
        final authorsAttribute = mangaRelation
            .firstWhere((relationship) => relationship['type'] == 'author');
        String authorNames = authorsAttribute["attributes"]["name"];
        setState(() {
          mangaCoversFileName.add(coverFileName);
          mangaAuthor.add(authorNames);
        });
      }
      setState(() {
        mangaTitles = mangaList.map((manga) {
          if (manga["attributes"]["title"].containsKey("en")) {
            return manga["attributes"]["title"]["en"];
          } else {
            return manga["attributes"]["title"]["ja-ro"];
          }
        }).toList();

        mangaStatus = mangaList.map((manga) {
          return manga["attributes"]["status"];
        }).toList();

        mangaDescription = mangaList.map((manga) {
          return manga["attributes"]["description"]["en"];
        }).toList();
      });
    } catch (e) {
      print(e);
    }

    mangaCovers = [];
    mangaCovers.length = mangaIds.length;
    for (int i = 0; i < mangaIds.length; i++) {
      final mangaId = mangaIds[i];
      final fileName = mangaCoversFileName[i];
      mangaCovers[i] = "https://uploads.mangadex.org/covers/$mangaId/$fileName";
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  searchManga(String p_title) async {
    try {
      mangaIds = [];
      const String baseUrl = 'https://api.mangadex.org';
      final String title = p_title;
      final response = await http.get(
        Uri.parse('$baseUrl/manga').replace(queryParameters: {'title': title}),
        headers: {'Content-Type': 'application/json'},
      );
      final responseData = jsonDecode(response.body);
      final mangaList = responseData['data'] as List<dynamic>;
      setState(() {
        mangaIds = mangaList.map((manga) => manga['id']).toList();
      });
    } catch (e) {
      print(e);
    }

    try {
      mangaTitles = [];
      mangaCoversFileName = [];
      mangaAuthor = [];
      mangaDescription = [];
      mangaStatus = [];
      List<dynamic> include = ["cover_art", "author"];
      const String baseUrl = 'https://api.mangadex.org';
      final response = await http.get(
        Uri.parse('$baseUrl/manga').replace(
            queryParameters: {'ids[]': mangaIds, 'includes[]': include}),
        headers: {'Content-Type': 'application/json'},
      );
      final responseData = jsonDecode(response.body);
      final mangaList = responseData['data'] as List<dynamic>;
      for (var manga in mangaList) {
        final mangaRelation = manga['relationships'] as List<dynamic>;
        final coverArt = mangaRelation
            .firstWhere((relationship) => relationship['type'] == 'cover_art');
        String coverFileName = coverArt["attributes"]["fileName"];
        final authorsAttribute = mangaRelation
            .firstWhere((relationship) => relationship['type'] == 'author');
        String authorNames = authorsAttribute["attributes"]["name"];
        setState(() {
          mangaCoversFileName.add(coverFileName);
          mangaAuthor.add(authorNames);
        });
      }
      setState(() {
        mangaTitles = mangaList.map((manga) {
          if (manga["attributes"]["title"].containsKey("en")) {
            return manga["attributes"]["title"]["en"];
          } else {
            return manga["attributes"]["title"]["ja-ro"];
          }
        }).toList();

        mangaStatus = mangaList.map((manga) {
          return manga["attributes"]["status"];
        }).toList();

        mangaDescription = mangaList.map((manga) {
          return manga["attributes"]["description"]["en"];
        }).toList();
      });

      // List<dynamic> include = ["cover_art"];
      // const String baseUrl = 'https://api.mangadex.org';
      // final response = await http.get(
      //   Uri.parse('$baseUrl/manga').replace(
      //       queryParameters: {'ids[]': mangaIds, 'includes[]': include}),
      //   headers: {'Content-Type': 'application/json'},
      // );
      // final responseData = jsonDecode(response.body);
      // final mangaList = responseData['data'] as List<dynamic>;
      // for (var manga in mangaList) {
      //   final mangaRelation = manga['relationships'] as List<dynamic>;
      //   final coverArt = mangaRelation
      //       .firstWhere((relationship) => relationship['type'] == 'cover_art');
      //   String coverFileName = coverArt["attributes"]["fileName"];
      //   setState(() {
      //     mangaCoversFileName.add(coverFileName);
      //   });
      // }
      // setState(() {
      //   mangaTitles = mangaList
      //       .map((manga) => manga["attributes"]["title"]["en"])
      //       .toList();
      // });
    } catch (e) {
      print(e);
    }

    mangaCovers = [];
    mangaCovers.length = mangaIds.length;
    for (int i = 0; i < mangaIds.length; i++) {
      final mangaId = mangaIds[i];
      final fileName = mangaCoversFileName[i];
      mangaCovers[i] = "https://uploads.mangadex.org/covers/$mangaId/$fileName";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        bottom: TabBar(
            controller: controller,
            labelColor: Theme.of(context).colorScheme.tertiary,
            indicatorColor: Theme.of(context).colorScheme.tertiary,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: [
              MyTab(icon: Icons.favorite, text: "Popular"),
              MyTab(icon: Icons.error_outline, text: "Latest"),
              MyTab(icon: Icons.filter_list, text: "Filter"),
            ]),
        title: cusSearchBar,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  if (this.cusIcon.icon == Icons.search) {
                    this.cusIcon = Icon(Icons.cancel);
                    this.cusSearchBar = TextField(
                      onSubmitted: (value) {
                        searchManga(value);
                        controller.animateTo(2);
                      },
                      cursorColor: Theme.of(context).colorScheme.inversePrimary,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        hintText: "Search...",
                      ),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    );
                  } else {
                    this.cusIcon = Icon(Icons.search);
                    this.cusSearchBar = Text("Browse");
                  }
                });
              },
              icon: cusIcon),
          IconButton(onPressed: () {}, icon: const Icon(Icons.filter_list)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.grid_view_sharp)),
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.tertiary,
            ))
          : TabBarView(
              controller: controller,
              physics: NeverScrollableScrollPhysics(),
              children: [
                  PopularPage(
                    mangaId: mangaIds,
                    mangaTitle: mangaTitles,
                    mangaCover: mangaCovers,
                    mangaAuthor: mangaAuthor,
                    mangaDescription: mangaDescription,
                    mangaStatus: mangaStatus,
                  ),
                  LatestPage(
                    mangaId: mangaIds,
                    mangaTitle: mangaTitles,
                    mangaCover: mangaCovers,
                    mangaAuthor: mangaAuthor,
                    mangaDescription: mangaDescription,
                    mangaStatus: mangaStatus,
                  ),
                  FilterPage(
                    mangaId: mangaIds,
                    mangaTitle: mangaTitles,
                    mangaCover: mangaCovers,
                    mangaAuthor: mangaAuthor,
                    mangaDescription: mangaDescription,
                    mangaStatus: mangaStatus,
                  )
                ]),
    );
  }
}
