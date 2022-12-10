import 'package:e_commerce_app/common/widgets/loader.dart';
import 'package:e_commerce_app/common/widgets/stars.dart';
import 'package:e_commerce_app/features/product_details/screens/productdetailsscreen.dart';
import 'package:e_commerce_app/features/home/services/searchservice.dart';
import 'package:e_commerce_app/models/products.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = "./searchscreen";
  final String searchKey;
  const SearchScreen({super.key, required this.searchKey});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchService = SearchService();

  List<Product>? productList;

  @override
  void initState() {
    super.initState();
    getSearchProduct(widget.searchKey);
  }

  void getSearchProduct(String searchparam) async {
    productList = await searchService.search(searchparam, context);
    setState(() {});
  }

  void productDetails(Product product) {
    Navigator.pushNamed(context, ProductDetailsScreen.routeName,
        arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          title: const Text("Search"),
        ),
      ),
      body: productList == null
          ? const Loader()
          : productList!.isEmpty
              ? const Center(
                  child: Text("Product not found"),
                )
              : ListView.builder(
                  itemCount: productList?.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (() {
                        productDetails(productList![index]);
                      }),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(
                              child: Image.network(
                                  height: 140,
                                  width: 140,
                                  fit: BoxFit.fitWidth,
                                  productList![index].images[0]),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    productList![index].name,
                                    maxLines: 2,
                                    overflow: TextOverflow.fade,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Stars(rating: 2.5),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "\$${productList![index].price}",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text("Eligible for free sheeping"),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text("In Stock"),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
