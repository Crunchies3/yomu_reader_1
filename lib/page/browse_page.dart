import 'package:flutter/material.dart';
import 'package:yomu_reader_1/page/browse_page/filter_page.dart';
import 'package:yomu_reader_1/page/browse_page/latest_page.dart';
import 'package:yomu_reader_1/page/browse_page/popular_page.dart';

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
              tabs: [
                Tab(
                  child: Row(
                    children: [
                      Icon(Icons.favorite),
                      SizedBox(
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
                      Icon(Icons.error_outline),
                      SizedBox(
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
                      Icon(Icons.error_outline),
                      SizedBox(
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
                )
              ]),
        ),
        Expanded(
          child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [PopularPage(), LatestPage(), FilterPage()]),
        )
      ],
    );
  }
}

class BrowsePageAppbar extends StatelessWidget {
  const BrowsePageAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: Text("Browse"),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        IconButton(onPressed: () {}, icon: Icon(Icons.grid_view_sharp)),
      ],
    );
  }
}
