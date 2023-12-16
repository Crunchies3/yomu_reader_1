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
  late TabController controller = TabController(length: 3, vsync: this);
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
                MyTab(icon: Icons.favorite, text: "Popular"),
                MyTab(icon: Icons.error_outline, text: "Latest"),
                MyTab(icon: Icons.filter_list, text: "Filter"),
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

//////////////////////////////////////////////////////////////////////////////////////////x

class BrowsePageAppbar extends StatefulWidget {
  const BrowsePageAppbar({super.key});

  @override
  State<BrowsePageAppbar> createState() => _BrowsePageAppbarState();
}

class _BrowsePageAppbarState extends State<BrowsePageAppbar> {
  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text("Browse");
  List<dynamic> mangaIds = [];

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
