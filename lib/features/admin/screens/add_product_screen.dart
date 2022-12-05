import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:e_commerce_app/common/widgets/custom_button.dart';
import 'package:e_commerce_app/common/widgets/custome_textfield.dart';
import 'package:e_commerce_app/constants/utils.dart';
import 'package:e_commerce_app/features/home/widgets/crouseimage.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  static const routeName = "./AddProduct";
  @override
  State<AddProduct> createState() => _AddProductState();
}

List<File>? images = [];

class _AddProductState extends State<AddProduct> {
  final TextEditingController _productnamecontroller = TextEditingController();
  final TextEditingController _pricecontroller = TextEditingController();
  final TextEditingController _descriptioncontroller = TextEditingController();
  final TextEditingController _quantitycontroller = TextEditingController();

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
      images = res;
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
                  child: (images!.isNotEmpty)
                      ? CarouselSlider(
                          options: CarouselOptions(
                            height: 200,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.8,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                          ),
                          items: images!.map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
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
                CustomButton(text: "Sell", onTap: (() {})),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
