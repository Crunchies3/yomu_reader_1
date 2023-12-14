import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const MyButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: this.onTap,
      child: Text(
        this.text,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(Size.fromWidth(400)),
        backgroundColor: MaterialStateProperty.all<Color>(
            Theme.of(context).colorScheme.tertiary),
        padding: MaterialStateProperty.all(EdgeInsets.all(10)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),)
      ),
    );
    // return GestureDetector(
    //   onTap: onTap,
    //   child: Container(
    //     decoration: BoxDecoration(
    //         color: Theme.of(context).colorScheme.tertiary,
    //         borderRadius: BorderRadius.circular(9)),
    //     padding: EdgeInsets.all(25),
    //     child: Center(
    //       child: Text(
    //         text,
    //         style: TextStyle(
    //           color: Colors.white,
    //           fontWeight: FontWeight.bold,
    //           fontSize: 16
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
