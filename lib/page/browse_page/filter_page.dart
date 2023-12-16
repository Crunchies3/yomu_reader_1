import 'package:flutter/material.dart';
class FilterPage extends StatefulWidget {
  final List<dynamic> mangaId;
  const FilterPage({super.key, required this.mangaId});

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
          itemCount: widget.mangaId.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 5,
            childAspectRatio: 1 / 1.75,
          ),
          itemBuilder: (context, index) {
            final mangaIDs = widget.mangaId[index];
            return Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  Container(
                    height: 270,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [Expanded(child: Text(mangaIDs))],
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
