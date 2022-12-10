import 'package:e_commerce_app/common/widgets/stars.dart';
import 'package:flutter/material.dart';

import '../../../models/products.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = "./productDetails";
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  Product? product;
  @override
  void initState() {
    super.initState();
    product = widget.product;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          PreferredSize(preferredSize: Size.fromHeight(50), child: AppBar()),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(product!.id.toString()), const Stars(rating: 10)],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(product!.name),
            const SizedBox(
              height: 10,
            ),
            Image.network(product!.images[0]),
          ],
        ),
      ),
    );
  }
}
