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

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
    onLoad();
    controller.addListener(() {
      setState(() {
        onLoad();
      });
    });
  }

  getLatestManga() {}

  getPopularManga() async {
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
    var final_order_query = {};

    var response =
        await http.get(Uri.parse("$base_url/manga").replace(queryParameters: {
      ...{
        "includedTags[]": included_tag_ids,
        "excludedTags[]": excluded_tag_ids,
      },
      ...final_order_query,
    }));

    var data = jsonDecode(response.body)["data"];
    setState(() {
      mangaIds = [for (var manga in data) manga["id"]];
    });
    PopularPage(mangaId: mangaIds,);
    print(mangaIds);
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

    try{
      mangaTitles.length = mangaIds.length;

      for(int index = 0; index < mangaTitles.length; index++) {
        final String id = mangaIds[index];
        String baseurl = "https://api.mangadex.org/manga/$id";
        final uri = Uri.parse(baseurl);
        final response = await http.get(uri);
        final body = response.body;
        final json = jsonDecode(body);
        setState(() {
          mangaTitles[index] = json["data"]["attributes"]["title"]["en"];
        });
      }


    } catch(e){
      print(e);
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
      body: TabBarView(
          controller: controller,
          physics: NeverScrollableScrollPhysics(),
          children: [
            PopularPage(
              mangaId: mangaIds,
            ),
            LatestPage(),
            FilterPage(
              mangaId: mangaIds,
              mangaTitle: mangaTitles,
            )
          ]),
    );
  }
}
