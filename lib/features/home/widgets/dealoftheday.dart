import 'package:flutter/material.dart';

class DealOfDay extends StatefulWidget {
  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Image.network(
        "https://animeshka.org/uploads/posts/2022-06/thumbs/1654548601_14-animeshka-org-p-macromir-krasivo-15.jpg",
        height: 300,
      ),
      Padding(
        padding: const EdgeInsets.only(
          left: 10,
        ),
        child: Container(
          alignment: Alignment.bottomLeft,
          child: Text("\$999"),
        ),
      ),
      Container(
        padding: const EdgeInsets.only(left: 10, top: 10),
        alignment: Alignment.bottomLeft,
        child: const Text("See all deals"),
      )
    ]);
  }
}
