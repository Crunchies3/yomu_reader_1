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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Text("Library"),
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

              return GridView.builder(
                  addAutomaticKeepAlives: true,
                  shrinkWrap: false,
                  itemCount: mangas.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                        child: buildImage(cover, mangaTitle, id, author, desc, status,index)
                    );
                  }
              );
            },

          )
        ));
  }

  Widget buildImage(cover, mangaTitle, id, author, desc, status,index) {
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
