import 'package:flutter/material.dart';
class PopularPage extends StatelessWidget {
  const PopularPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GridView.builder(
        shrinkWrap: false,
          itemCount: 10,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 5, childAspectRatio: 1/1.75,),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                children: [
                  Container(
                    color: Colors.red,
                    child: Image(
                      fit: BoxFit.contain,
                      image: AssetImage("asset/image/one_piece.jpg"),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text("One piece")
                    ],
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            );
          }
      ),
    );
  }
}
