import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yomu_reader_1/page/description_text.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  String desc =  "A dark gloomy castle with endless stairways and an ancient library. Scary, mysterious creatures live here, hiding in the night. One day, a girl who lost her memory ends up there. Who is she and how can she get back? And, most importantly, how will the owner of the castle decide her fate?";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 150,
                    width: 100,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "One Piece",
                        style: TextStyle(fontSize: 22),
                      ),
                      Text(
                        "Oda Eiichiro",
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Icon(CupertinoIcons.clock, size: 12,),
                          SizedBox(width: 5,),
                          Text("Ongoing", style: TextStyle(fontSize: 12),)
                        ],
                      ),

                    ],
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
                                    color: Colors.grey,
                                  )),
                            ]),
                          ))),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: DescriptionText(desc: desc,)
              )
            ],
          ),
        ),
      ),
    );
  }
}
