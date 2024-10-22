import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yomu_reader_1/page/screen/detail_screen.dart';

import '../my_classes/services/firestore.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final FireStoreService fireStoreService = FireStoreService();
  bool isLibraryEmpty = true;
  bool isList = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Text("Library"),
          actions: [
            IconButton(
                onPressed: () {
                  if (isList) {
                    setState(() {
                      isList = false;
                    });
                  } else {
                    setState(() {
                      isList = true;
                    });
                  }
                },
                icon: isList ? Icon(Icons.grid_view_sharp) : Icon(Icons.list)),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(5.0),
            child: StreamBuilder(
              stream: fireStoreService.getMangaLibrary(),
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
                  isLibraryEmpty = false;
                } else {
                  isLibraryEmpty = true;
                }

                return isLibraryEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.dashboard_outlined,
                              size: 70,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Your library is empty",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                          ],
                        ),
                      )
                    : isList
                        ? Padding(
                          padding:  EdgeInsets.all(5.0),
                          child: ListView.builder(
                              itemCount: mangas.length,
                              itemBuilder: (context, index) {
                                final manga = mangas[index];
                                final mangaTitle = manga['manga_title'];
                                final id = manga['manga_id'];
                                final author = manga['manga_author'];
                                final desc = manga['manga_description'];
                                final status = manga['manga_status'];
                                final cover = manga['cover_link'];
                                return ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailScreen(
                                              title: mangaTitle,
                                              id: id,
                                              author: author,
                                              status: status,
                                              desc: desc,
                                              image: cover,
                                            )));
                                  },
                                  leading: Container(
                                    color: Theme.of(context).colorScheme.primary,
                                    height: 100,
                                    width: 40,
                                    child: Image.network(
                                      cover,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  title: Text(mangaTitle),
                                  subtitle: Text(""),
                                );
                              }),
                        )
                        : GridView.builder(
                            addAutomaticKeepAlives: true,
                            shrinkWrap: false,
                            itemCount: mangas.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 5,
                              childAspectRatio: 1 / 1.75,
                            ),
                            itemBuilder: (context, index) {
                              final manga = mangas[index];
                              final mangaTitle = manga['manga_title'];
                              final id = manga['manga_id'];
                              final author = manga['manga_author'];
                              final desc = manga['manga_description'];
                              final status = manga['manga_status'];
                              final cover = manga['cover_link'];
                              return Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: buildImage(cover, mangaTitle, id,
                                      author, desc, status, index));
                            });
              },
            )));
  }

  Widget buildImage(cover, mangaTitle, id, author, desc, status, index) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailScreen(
                          title: mangaTitle,
                          id: id,
                          author: author,
                          status: status,
                          desc: desc,
                          image: cover,
                        )));
          },
          child: Container(
            height: 270,
            color: Theme.of(context).colorScheme.primary,
            child: CachedNetworkImage(
              imageUrl: cover,
              fit: BoxFit.fill,
              errorWidget: (BuildContext context, String url, dynamic error) =>
                  const Icon(Icons.error),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                  child: Text(
                mangaTitle,
                style: const TextStyle(fontSize: 12),
              ))
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
