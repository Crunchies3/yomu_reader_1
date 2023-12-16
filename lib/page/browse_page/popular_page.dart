import 'package:flutter/material.dart';

class PopularPage extends StatefulWidget {
  final List<dynamic> mangaId;
  const PopularPage({super.key, required this.mangaId});

  @override
  State<PopularPage> createState() => _PopularPageState();
}

class _PopularPageState extends State<PopularPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
              return Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    Container(
                      height: 285,
                      color: Theme.of(context).colorScheme.inversePrimary,
                      child: const Image(
                        fit: BoxFit.contain,
                        image: AssetImage("asset/image/one_piece.jpg"),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      children: [Text("One piece")],
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
