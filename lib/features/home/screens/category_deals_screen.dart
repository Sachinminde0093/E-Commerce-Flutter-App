import 'package:e_commerce_app/common/widgets/loader.dart';
import 'package:e_commerce_app/features/home/services/homeservice.dart';
import 'package:e_commerce_app/models/products.dart';
import 'package:flutter/material.dart';

HomeService homeService = HomeService();

class CategoryDealsScreen extends StatefulWidget {
  static const String routeName = './CategoryDealsScreen';
  final String category;
  const CategoryDealsScreen({
    super.key,
    required this.category,
  });

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  List<Product>? list;

  void fetchCategoryProduct() async {
    list = await homeService.fetchCategoryProduct(context, widget.category);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchCategoryProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65),
        child: AppBar(
          title: Text(widget.category),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.topLeft,
            child: Text(
              " Keep Shoping For Essentials ${widget.category}",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            height: 170,
            child: list == null
                ? Loader()
                : list!.isEmpty
                    ? const Text("No product availabele")
                    : GridView.builder(
                        scrollDirection: Axis.horizontal,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                childAspectRatio: 1.4,
                                mainAxisSpacing: 10),
                        itemBuilder: ((context, index) {
                          Product product = list![index];
                          return Column(
                            children: [
                              SizedBox(
                                height: 150,
                                child: Image.network(product.images[0]),
                              ),
                              const Text("\$ 90")
                            ],
                          );
                        }),
                        itemCount: list!.length,
                      ),
          )
        ],
      ),
    );
  }
}
