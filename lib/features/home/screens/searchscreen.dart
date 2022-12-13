import 'package:e_commerce_app/common/widgets/loader.dart';
import 'package:e_commerce_app/common/widgets/stars.dart';
import 'package:e_commerce_app/features/product_details/screens/productdetailscreen.dart';
import 'package:e_commerce_app/features/home/services/searchservice.dart';
import 'package:e_commerce_app/models/products.dart';
import 'package:flutter/material.dart';

import '../../../constants/globalvariables.dart';

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

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(
                              left: 6,
                            ),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: 'Search Amazon.in',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(Icons.mic, color: Colors.black, size: 25),
              ),
            ],
          ),
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
