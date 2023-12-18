import 'package:flutter/material.dart';

import '../screen/detail_screen.dart';

class FilterPage extends StatefulWidget {
  final List<dynamic> mangaId;
  final List<dynamic> mangaTitle;
  final List<dynamic> mangaCover;

  const FilterPage(
      {super.key,
      required this.mangaId,
      required this.mangaTitle,
      required this.mangaCover});

  @override
  State<FilterPage> createState() => FilterPageState();
}

class FilterPageState extends State<FilterPage> {
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
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GridView.builder(
          shrinkWrap: false,
          itemCount: widget.mangaTitle.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 5,
            childAspectRatio: 1 / 1.75,
          ),
          itemBuilder: (context, index) {
            final mangaTitle = widget.mangaTitle[index];
            final id = widget.mangaId[index];
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
                                    author: "",
                                    status: "",
                                    desc: "ahhhhhhhhhhhhhhhh",
                                    image: "",
                                  )));
                    },
                    child: Container(
                      height: 270,
                      color: Theme.of(context).colorScheme.secondary,
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
    );
  }
}
