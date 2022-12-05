import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({super.key});

  @override
  Widget build(BuildContext context) {
    List<dynamic> list = [
      "https://animeshka.org/uploads/posts/2022-06/thumbs/1654548601_14-animeshka-org-p-macromir-krasivo-15.jpg",
      "https://animeshka.org/uploads/posts/2022-06/thumbs/1654548601_14-animeshka-org-p-macromir-krasivo-15.jpg",
      "https://animeshka.org/uploads/posts/2022-06/thumbs/1654548601_14-animeshka-org-p-macromir-krasivo-15.jpg",
      "https://animeshka.org/uploads/posts/2022-06/thumbs/1654548601_14-animeshka-org-p-macromir-krasivo-15.jpg",
      "https://animeshka.org/uploads/posts/2022-06/thumbs/1654548601_14-animeshka-org-p-macromir-krasivo-15.jpg",
      "https://animeshka.org/uploads/posts/2022-06/thumbs/1654548601_14-animeshka-org-p-macromir-krasivo-15.jpg",
    ];
    return SizedBox(
      height: 60,
      child: Container(
        height: 50,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return ClipRRect(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.network(list[index]),
              ),
            );
          },
          itemCount: list.length,
        ),
      ),
    );
  }
}
