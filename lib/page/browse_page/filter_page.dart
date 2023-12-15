import 'package:flutter/material.dart';
class FilterPage extends StatelessWidget {
  const FilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GridView.builder(
          shrinkWrap: false,
          itemCount: 5,
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
                    height: 300,
                    color: Theme.of(context).colorScheme.secondary,
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
    );
  }
}
