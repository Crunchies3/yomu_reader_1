import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yomu_reader_1/my_classes/services/firestore.dart';
import 'package:yomu_reader_1/page/screen/detail_screen.dart';
import 'package:yomu_reader_1/page/screen/manga_content.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final FireStoreService fireStoreService = FireStoreService();
  bool isHistoryEmpty = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text("History"),
        ),
        body: Padding(
            padding: EdgeInsets.all(5.0),
            child: StreamBuilder(
              stream: fireStoreService.getMangaHistory(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data == null) {
                  return const Text("No Data");
                }

                final mangas = snapshot.data!.docs;

                if (mangas.length > 0) {
                  isHistoryEmpty = false;
                } else {
                  isHistoryEmpty = true;
                }

                return isHistoryEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.history,
                              size: 70,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Nothing read lately",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: mangas.length,
                        itemBuilder: (context, index) {
                          final manga = mangas[index];

                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MangaContent(
                                            mangaId: manga['manga_id'],
                                            mangaTitle: manga['manga_title'],
                                            mangaChapters: manga['chapter_ids'],
                                            index: manga['recent_chapter'],
                                            author: manga['manga_author'],
                                            status: manga['manga_status'],
                                            desc: manga['manga_description'],
                                            image: manga['cover_link'],
                                          )));
                            },
                            leading: Container(
                                color: Theme.of(context).colorScheme.primary,
                                height: 100,
                                width: 40,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailScreen(
                                                  title: manga['manga_title'],
                                                  id: manga['manga_id'],
                                                  author: manga['manga_author'],
                                                  status: manga['manga_status'],
                                                  desc: manga[
                                                      'manga_description'],
                                                  image: manga['cover_link'],
                                                )));
                                  },
                                  child: Image.network(
                                    manga['cover_link'],
                                    fit: BoxFit.fill,
                                  ),
                                )),
                            title: Text(manga['manga_title']),
                            subtitle: Text(
                              manga['chapter_title'],
                              style: TextStyle(
                                  fontSize: 11, color: Colors.grey[400]),
                            ),
                          );
                        },
                      );
              },
            )));
  }
}
