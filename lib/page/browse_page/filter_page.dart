import 'package:flutter/material.dart';
class FilterPage extends StatefulWidget {
  final List<dynamic> mangaId;
  const FilterPage({super.key, required this.mangaId});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
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
                    height: 285,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [Text(mangaIDs)],
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
