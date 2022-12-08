import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:e_commerce_app/common/widgets/custom_button.dart';
import 'package:e_commerce_app/common/widgets/custome_textfield.dart';
import 'package:e_commerce_app/constants/utils.dart';
import 'package:e_commerce_app/features/admin/screens/adminscreen.dart';
import 'package:e_commerce_app/features/admin/services/adminservices.dart';
import 'package:flutter/material.dart';

AdminServices adminServices = AdminServices();

class AddProduct extends StatefulWidget {
  static const routeName = "./AddProduct";
  @override
  State<AddProduct> createState() => _AddProductState();
}

List<File> images = [];

class _AddProductState extends State<AddProduct> {
  final TextEditingController _productnamecontroller = TextEditingController();
  final TextEditingController _pricecontroller = TextEditingController();
  final TextEditingController _descriptioncontroller = TextEditingController();
  final TextEditingController _quantitycontroller = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  List<String> categoriesList = [
    'Mobile',
    'Essentials',
    'Appliences',
    'Book',
    'Fashion'
  ];

  String category = "Mobile";

  void selectImages() async {
    var res = await picImages();
    setState(() {
      images = res ?? [];
    });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptioncontroller;
    _pricecontroller;
    _productnamecontroller;
    _quantitycontroller;
  }

  void sellProducts() {
    if (_formkey.currentState!.validate() && images.isNotEmpty) {
      adminServices.sellProduct(
          context: context,
          name: _productnamecontroller.text,
          description: _descriptioncontroller.text,
          price: double.parse(_pricecontroller.text),
          quantity: double.parse(_quantitycontroller.text),
          category: category,
          images: images);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          title: const Text("Add Product"),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    selectImages();
                  },
                  child: (images.isNotEmpty)
                      ? CarouselSlider(
                          options: CarouselOptions(
                            height: 200,
                            // aspectRatio: 16 / 9,
                            // viewportFraction: 0.8,
                            initialPage: 0,
                            // enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 2),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            // enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                          ),
                          items: images.map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.file(
                                    i,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        )
                      : DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.folder_open),
                                  Text(
                                    "Select prodect image",
                                    style: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontSize: 15,
                                    ),
                                  )
                                ]),
                          ),
                        ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomeTextField(
                    controller: _productnamecontroller, hint: "Product Name"),
                const SizedBox(
                  height: 30,
                ),
                CustomeTextField(
                  controller: _descriptioncontroller,
                  hint: "Description",
                  maxline: 7,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomeTextField(controller: _pricecontroller, hint: "Price"),
                const SizedBox(
                  height: 10,
                ),
                CustomeTextField(
                    controller: _quantitycontroller, hint: "Quantity"),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: DropdownButton(
                      value: category,
                      items: categoriesList.map((String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (String? newval) {
                        setState(() {
                          category = newval!;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomButton(
                    text: "Sell",
                    onTap: (() {
                      sellProducts();
                    })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
