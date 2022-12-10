import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/common/widgets/custom_button.dart';
import 'package:e_commerce_app/common/widgets/stars.dart';
import 'package:e_commerce_app/constants/globalvariables.dart';
import 'package:e_commerce_app/features/product_details/services/rateproduct.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../models/products.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = "./productDetails";
  final Product product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ProductServices productServices = ProductServices();

  Product? product;

  double avgRating = 0;

  double myRating = 0;

  @override
  void initState() {
    super.initState();

    product = widget.product;
    double totalRating = 0;

    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating;
      if (widget.product.rating![i].userId == "638dd6480074d9b17c5ba6b9") {
        myRating = widget.product.rating![i].rating;
        debugPrint(widget.product.rating![i].rating.toString());
      }
    }

    if (totalRating != 0) {
      avgRating = totalRating / widget.product.rating!.length;
    }
  }

  void rateProduct(double rating) {
    productServices.rateProduct(context, widget.product.id!, rating);
    setState(() {
      myRating = rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50), child: AppBar()),
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
                children: [
                  Text(product!.id.toString()),
                  Stars(rating: myRating.toDouble()),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(product!.name),
              const SizedBox(
                height: 10,
              ),
              CarouselSlider(
                items: widget.product.images.map(
                  (i) {
                    return Builder(
                      builder: (BuildContext context) => Image.network(
                        i,
                        fit: BoxFit.cover,
                        height: 200,
                      ),
                    );
                  },
                ).toList(),
                options: CarouselOptions(
                  viewportFraction: 1,
                  height: 300,
                ),
              ),
              Container(
                color: Colors.black12,
                height: 5,
              ),
              const SizedBox(
                height: 10,
              ),
              Text("\$${product!.price}"),
              Container(
                color: Colors.black12,
                height: 5,
              ),
              CustomButton(text: "Buy Now", onTap: () {}),
              const SizedBox(
                height: 10,
              ),
              CustomButton(text: "Add To Cart", onTap: () {}),
              Container(
                color: Colors.black12,
                height: 5,
              ),
              RatingBar.builder(
                itemBuilder: (context, _) {
                  return const Icon(Icons.star,
                      color: GlobalVariables.secondaryColor);
                },
                initialRating: myRating.toDouble(),
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 2),
                onRatingUpdate: (rating) {
                  rateProduct(rating);
                },
              )
            ]),
      ),
    );
  }
}
