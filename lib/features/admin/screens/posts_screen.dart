import 'package:e_commerce_app/common/widgets/loader.dart';
import 'package:e_commerce_app/features/account/widgets/single_product.dart';
import 'package:e_commerce_app/features/admin/screens/add_product_screen.dart';
import 'package:e_commerce_app/features/admin/services/admin_services.dart';
import 'package:e_commerce_app/models/products.dart';
import 'package:flutter/material.dart';

class PostsScreen extends StatefulWidget {
  static const String routeName = '/post-screen';

  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<Product>? products;
  final AdminServices adminServices = AdminServices();

  bool flag = true;

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    products = await adminServices.fetchAllProducts(context);
    setState(() {
      flag = false;
    });
  }

  void deleteProduct(Product product, int index) {
    adminServices.deleteProduct(
      context: context,
      product: product,
      onSuccess: () {
        products!.removeAt(index);
        setState(() {});
      },
    );
  }

  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: products == null && flag
          ? const Loader()
          : products == null
              ? const Center(
                  child: Text("Products are not available"),
                )
              : Container(
                  padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
                  child: GridView.builder(
                    itemCount: products!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      final productData = products![index];
                      return Column(
                        children: [
                          SizedBox(
                            height: 140,
                            child: SingleProduct(
                              image: productData.images[0],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Text(
                                    productData.name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () =>
                                      deleteProduct(productData, index),
                                  icon: const Icon(
                                    Icons.delete_outline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddProduct,
        tooltip: 'Add a Product',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
