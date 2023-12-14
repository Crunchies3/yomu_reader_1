import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yomu_reader_1/page/library_page.dart';
import 'package:yomu_reader_1/page/updates_page.dart';

import 'browse_page.dart';
import 'history_page.dart';
import 'more_page.dart';


class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  int currentPageIndex = 0;
  Widget currentPage = LibraryPage();
  Widget currentAppbar = LibraryAppbar();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0), // here the desired height
          child: currentAppbar,
        ),
        body: currentPage,
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
              indicatorColor: Theme.of(context).colorScheme.tertiary,
              labelTextStyle: MaterialStateProperty.all(TextStyle(fontSize: 14,))
          ),
          child: NavigationBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            onDestinationSelected: (int index){
              setState(() {
                currentPageIndex = index;

                switch (index) {
                  case 0:
                    currentPage = LibraryPage();
                    currentAppbar = LibraryAppbar();
                    break;
                  case 1:
                    currentPage = UpdatesPage();
                    currentAppbar = UpdatesPageAppbar();
                    break;
                  case 2:
                    currentPage = HistoryPage();
                    currentAppbar = HistoryPageAppbar();
                    break;
                  case 3:
                    currentPage = BrowsePage();
                    currentAppbar = BrowsePageAppbar();
                    break;
                  case 4: currentPage = MorePage();
                  currentAppbar = AppBar();
                }
              });
            },
            selectedIndex: currentPageIndex,
            destinations: [
              NavigationDestination(icon: Icon(color: Theme.of(context).colorScheme.inversePrimary,Icons.book), label: "library"),
              NavigationDestination(icon: Icon(color: Theme.of(context).colorScheme.inversePrimary,Icons.notifications_active_sharp), label: "Updates"),
              NavigationDestination(icon: Icon(color: Theme.of(context).colorScheme.inversePrimary,Icons.history), label: "History"),
              NavigationDestination(icon: Icon(color: Theme.of(context).colorScheme.inversePrimary,Icons.explore), label: "Browse"),
              NavigationDestination(icon: Icon(color: Theme.of(context).colorScheme.inversePrimary,Icons.more_horiz), label: "More"),
            ],
          ),
        ),
      ),
    );
  }
}
