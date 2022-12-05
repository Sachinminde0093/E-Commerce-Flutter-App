import 'package:flutter/material.dart';

class OrderList extends StatefulWidget {
  const OrderList({super.key});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  List<dynamic> list = [
    "https://animeshka.org/uploads/posts/2022-06/thumbs/1654548601_14-animeshka-org-p-macromir-krasivo-15.jpg",
    "https://animeshka.org/uploads/posts/2022-06/thumbs/1654548601_14-animeshka-org-p-macromir-krasivo-15.jpg",
    "https://animeshka.org/uploads/posts/2022-06/thumbs/1654548601_14-animeshka-org-p-macromir-krasivo-15.jpg",
    "https://animeshka.org/uploads/posts/2022-06/thumbs/1654548601_14-animeshka-org-p-macromir-krasivo-15.jpg",
    "https://animeshka.org/uploads/posts/2022-06/thumbs/1654548601_14-animeshka-org-p-macromir-krasivo-15.jpg",
    "https://animeshka.org/uploads/posts/2022-06/thumbs/1654548601_14-animeshka-org-p-macromir-krasivo-15.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Image.network(list[index]);
        },
        itemCount: list.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
