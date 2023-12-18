import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yomu_reader_1/page/description_text.dart';

class DetailScreen extends StatefulWidget {
  final String title;
  final String id;
  final String author;
  final String desc;
  final String status;
  final image;

  const DetailScreen(
      {super.key,
      required this.title,
      required this.id,
      required this.author,
      required this.desc,
      required this.status,
      required this.image});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(),
      body: Scrollbar(
        interactive: true,
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 150,
                        width: 100,
                        color: Colors.grey,
                        child: Image.network(
                          widget.image,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: TextStyle(fontSize: 22),
                            ),
                            Row(children: [
                              const Icon(
                                CupertinoIcons.person,
                                size: 12,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.author,
                                style: TextStyle(fontSize: 12),
                              ),
                            ]),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(
                                  CupertinoIcons.clock,
                                  size: 12,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  widget.status,
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: FilledButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    Theme.of(context).colorScheme.primary),
                              ),
                              onPressed: () {},
                              child: Padding(
                                padding: EdgeInsets.all(6),
                                child: Column(children: [
                                  Icon(
                                    Icons.favorite_border,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
                                  ),
                                  Text("Add to library",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12)),
                                ]),
                              ))),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      child: DescriptionText(
                    desc: widget.desc,
                  )),
                  Text(
                    "315 chapters",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 50,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('Item ${index + 1}'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
