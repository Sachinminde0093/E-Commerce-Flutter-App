import 'package:e_commerce_app/common/widgets/loader.dart';
import 'package:e_commerce_app/features/admin/models/products.dart';
import 'package:e_commerce_app/features/admin/screens/add_product_screen.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  static const routeName = "./PostScreen";

  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<Product>? productList;

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  void fetchAllProducts() async {
    productList = await adminServices.fetchAllProduct(context);
    setState(() {});
  }

  void deleteProduct(int index, String? id) {
    adminServices.deleteProduct(context, id!, () {
      productList?.removeAt(index);
      setState(() {});
    });
  }

  void loadImage(int index) {}

  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProduct.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: productList == null
          ? const Loader()
          // : Center(
          //     child: Text("Hava hava"),
          //   ),
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: productList!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                          height: 140,
                          child: Image.network(productList![index].images[0])),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              productList![index].name,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              deleteProduct(index, productList![index].id);
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add Product",
        onPressed: (() {
          navigateToAddProduct();
        }),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
