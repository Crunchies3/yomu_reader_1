import 'package:flutter/material.dart';
import 'package:yomu_reader_1/page/screen/detail_screen.dart';

class PopularPage extends StatefulWidget {
  final List<dynamic> mangaId;
  final List<dynamic> mangaTitle;
  final List<dynamic> mangaCover;
  final List<dynamic> mangaAuthor;
  final List<dynamic> mangaStatus;
  final List<dynamic> mangaDescription;

  const PopularPage(
      {super.key,
      required this.mangaId,
      required this.mangaTitle,
      required this.mangaCover,
      required this.mangaAuthor,
      required this.mangaStatus,
      required this.mangaDescription});

  @override
  State<PopularPage> createState() => PopularPageState();
}

class PopularPageState extends State<PopularPage> {
  final List<dynamic> mangaTitles = [""];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getTitles());
  }

  void getTitles() async {
    mangaTitles[0] = widget.mangaId[0];
    print(mangaTitles[0]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: GridView.builder(
            addAutomaticKeepAlives: true,
            shrinkWrap: false,
            itemCount: widget.mangaId.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              childAspectRatio: 1 / 1.75,
            ),
            itemBuilder: (context, index) {
              final mangaTitle = widget.mangaTitle[index];
              final id = widget.mangaId[index];
              final author = widget.mangaAuthor[index];
              final desc = widget.mangaDescription[index];
              final status = widget.mangaStatus[index];
              final cover = widget.mangaCover[index];
              return Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
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
                        color: Theme.of(context).colorScheme.inversePrimary,
                        child: Image.network(
                          widget.mangaCover[index],
                          fit: BoxFit.fill,
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
                            style: TextStyle(fontSize: 12),
                          ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
