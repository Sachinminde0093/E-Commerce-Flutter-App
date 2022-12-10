import 'dart:convert';

import 'dart:io';

import 'package:e_commerce_app/constants/error_handling.dart';
import 'package:e_commerce_app/constants/globalvariables.dart';
import 'package:e_commerce_app/constants/utils.dart';
import 'package:e_commerce_app/features/admin/screens/posts_screen.dart';
import 'package:e_commerce_app/provider/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/products.dart';

class AdminServices {
  final provider = UserProvider();
  void sellProduct(
      {required BuildContext context,
      required String name,
      required String description,
      required double price,
      required double quantity,
      required String category,
      required List<File> images}) async {
    try {
      List<String> imagesurls = [];

      final cloudinary = CloudinaryPublic("dmlheuvc9", "nvmtjqpa");

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));

        imagesurls.add(res.secureUrl);
      }

      Product product = Product(
          name: name,
          description: description,
          price: price,
          quantity: quantity,
          category: category,
          images: imagesurls);

      debugPrint(product.toJson());

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth-token');

      http.Response res = await http.post(Uri.parse("$uri/admin/add-product"),
          body: product.toJson(),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'auth-token': token!
          });

      // print(res.body.toString());

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            Navigator.pushNamed(context, PostScreen.routeName);
            showSnackBar(context, "Data saved succesfully");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

//fetch all Products

  Future<List<Product>> fetchAllProduct(BuildContext context) async {
    List<Product> productList = [];

    
    try {

SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString('auth-token');

      debugPrint(token);
      
      http.Response res =
          await http.get(Uri.parse("$uri/admin/get-product"), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': token ?? "",
      });

      // debugPrint(res.body.toString());

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (err) {
      showSnackBar(context, " Error $err.toString()");
    }
    // debugPrint(productList.toString());
    return productList;
  }

  void deleteProduct(
      BuildContext context, String id, VoidCallback onSuccess) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString('auth-token');

      debugPrint(id);

      http.Response res = await http.post(
          Uri.parse("$uri/admin/delete-product"),
          body: jsonEncode({"id": id}),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'auth-token': token!,
          });

     
      debugPrint(res.body);
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            onSuccess();
          });
    } catch (err) {
      showSnackBar(context, "$err error");
    }
  }
}
