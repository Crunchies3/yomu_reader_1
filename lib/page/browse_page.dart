import 'package:flutter/material.dart';
import 'package:yomu_reader_1/page/browse_page/filter_page.dart';
import 'package:yomu_reader_1/page/browse_page/latest_page.dart';
import 'package:yomu_reader_1/page/browse_page/popular_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BrowsePage extends StatefulWidget {
  const BrowsePage({super.key});

  @override
  State<BrowsePage> createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage>
    with SingleTickerProviderStateMixin {
  late TabController controller;



  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);

    controller.addListener(() {
      setState(() {
      });
    });
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  int getCurrentIndex() {
    return controller.index;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Theme.of(context).colorScheme.primary,
          child: TabBar(
              controller: controller,
              labelColor: Theme.of(context).colorScheme.tertiary,
              indicatorColor: Theme.of(context).colorScheme.tertiary,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              tabs: [
                Tab(
                  child: Row(
                    children: [
                      const Icon(Icons.favorite),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Popular",
                        style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.inversePrimary),
                      )
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Latest",
                        style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.inversePrimary),
                      )
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    children: [
                      const Icon(Icons.filter_list),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Filter",
                        style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.inversePrimary),
                      )
                    ],
                  ),
                ),
              ]),
        ),
         Expanded(
          child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: controller,
              children: [
                PopularPage(),
                LatestPage(),
                FilterPage(
                  mangaId: [],
                )
              ]),
        )
      ],
    );
  }
}

class BrowsePageAppbar extends StatefulWidget {
  const BrowsePageAppbar({super.key});

  @override
  State<BrowsePageAppbar> createState() => _BrowsePageAppbarState();
}

class _BrowsePageAppbarState extends State<BrowsePageAppbar> {
  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text("Browse");
  List<dynamic> mangaIds = [];
  var currentPageIndex;

  void updateState() {
    setState(() {
      currentPageIndex = _BrowsePageState().getCurrentIndex();
    });
  }

  searchManga(String p_title) async {
    try {
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
      FilterPage(mangaId: mangaIds);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: Text(
        "Browser ${currentPageIndex}"
      ) ,
      actions: [
        IconButton(
            onPressed: () {
              setState(() {
                if (this.cusIcon.icon == Icons.search) {
                  this.cusIcon = Icon(Icons.cancel);
                  this.cusSearchBar = TextField(
                    onSubmitted: (value) {
                      searchManga(value);
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
    );
  }
}
