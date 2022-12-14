import 'dart:convert';

import 'package:e_commerce_app/constants/error_handling.dart';
import 'package:e_commerce_app/constants/utils.dart';
import 'package:e_commerce_app/models/products.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/globalvariables.dart';

class HomeService {
  Future<List<Product>> fetchCategoryProduct(
      BuildContext context, String category) async {
    List<Product> productList = [];
    try {
      // debugPrint("product");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth-token');

      http.Response res = await http.get(
          Uri.parse("$uri/api/get-category-product?category=$category"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'auth-token': token ?? ''
          });

      // debugPrint(res.body);

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              productList.add(
                Product.fromJson(
                  jsonEncode(jsonDecode(res.body)[i]),
                ),
              );
            }
          });
    } catch (err) {
      showSnackBar(context, "error $err");
    }
    debugPrint(productList.length.toString());
    return productList;
  }

  Future<Product> fetchDealOfDay({
    required BuildContext context,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth-token');
    Product product = Product(
      name: '',
      description: '',
      quantity: 0,
      images: [],
      category: '',
      price: 0,
    );

    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/deal-of-day'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': token ?? '',
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          product = Product.fromJson(res.body);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return product;
  }
}
