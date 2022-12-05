import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselImage extends StatelessWidget {
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
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      items: list.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                i,
                fit: BoxFit.cover,
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
