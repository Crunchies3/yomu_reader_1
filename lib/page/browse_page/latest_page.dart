import 'package:flutter/material.dart';
class LatestPage extends StatelessWidget {
  const LatestPage({super.key});

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
                    color: Theme.of(context).colorScheme.secondary,
                    height: 300,
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
