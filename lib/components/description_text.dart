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

    if (widget.desc.length > 1000){
      flag = true;
    }

    if (widget.desc.length > 50) {
      firstHalf = widget.desc.substring(0, 150);
      secondHalf = widget.desc.substring(150, widget.desc.length);
    } else {
      firstHalf = widget.desc;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? new Text(firstHalf)
          : new Column(
        children: <Widget>[
          new Text(flag ? (firstHalf + "...") : (firstHalf + secondHalf),style: TextStyle(fontSize: 12, color: Colors.grey[400]),),
          SizedBox(height: 5,),
          new InkWell(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  flag ? Icons.expand_more: Icons.expand_less,
                  color: Theme.of(context).colorScheme.tertiary,
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
