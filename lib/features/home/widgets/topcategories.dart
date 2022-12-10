import 'package:e_commerce_app/constants/globalvariables.dart';
import 'package:e_commerce_app/features/home/screens/category_deals_screen.dart';
import 'package:flutter/cupertino.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({super.key});

  @override
  Widget build(BuildContext context) {
    var list = GlobalVariables.categoryImages;
    void showCategoryproduct(String category) {
      Navigator.pushNamed(context, CategoryDealsScreen.routeName,
          arguments: category);
    }

    return SizedBox(
      height: 60,
      child: SizedBox(
        height: 50,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            Map map = list[index];
            return GestureDetector(
              onTap: () {
                showCategoryproduct(map["title"]);
              },
              child: ClipRRect(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(map["image"]),
                ),
              ),
            );
          },
          itemCount: list.length,
        ),
      ),
    );
  }
}
