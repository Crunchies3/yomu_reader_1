import 'package:flutter/material.dart';
import 'package:yomu_reader_1/page/browse_page/filter_page.dart';
import 'package:yomu_reader_1/page/browse_page/latest_page.dart';
import 'package:yomu_reader_1/page/browse_page/popular_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BrowsePage extends StatelessWidget {
  const BrowsePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Theme.of(context).colorScheme.primary,
          child: TabBar(
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
        const Expanded(
          child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [PopularPage(), LatestPage(), FilterPage()]),
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

  searchManga(String p_title) async {
    try {
      final String baseUrl = 'https://api.mangadex.org';
      final String title = p_title;
        final response = await http.get(Uri.parse('$baseUrl/manga').replace(queryParameters: {
          'title': title
        }),
            headers: {'Content-Type': 'application/json'},
        );
        final responseData = jsonDecode(response.body);
        final mangaList = responseData['data'] as List<dynamic>;
        final mangaIds = mangaList.map((manga) => manga['id']).toList();
        print(mangaIds);

    } catch(e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: cusSearchBar,
      actions: [
        IconButton(onPressed: () {
          setState(() {
            if(this.cusIcon.icon == Icons.search) {
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
        }, icon: cusIcon),
        IconButton(onPressed: () {}, icon: const Icon(Icons.filter_list)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.grid_view_sharp)),
      ],
    );
  }
}
