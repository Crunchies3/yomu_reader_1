import 'package:flutter/material.dart';

class DescriptionText extends StatefulWidget {
  final String desc;

  const DescriptionText({super.key, required this.desc});

  @override
  State<DescriptionText> createState() => _DescriptionTextState();
}

class _DescriptionTextState extends State<DescriptionText> {

  String firstHalf= "";
  String secondHalf= "";
  bool flag = false;

  @override
  void initState() {
    super.initState();

    if (widget.desc.length > 50) {
      firstHalf = widget.desc.substring(0, 50);
      secondHalf = widget.desc.substring(50, widget.desc.length);
    } else {
      firstHalf = widget.desc;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: secondHalf.isEmpty
          ? new Text(firstHalf)
          : new Column(
        children: <Widget>[
          new Text(flag ? (firstHalf + "...") : (firstHalf + secondHalf)),
          SizedBox(height: 5,),
          new InkWell(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  flag ? Icons.expand_more: Icons.expand_less,
                ),
              ],
            ),
            onTap: () {
              setState(() {
                flag = !flag;
              });
            },
          ),
        ],
      ),
    );
  }
}
