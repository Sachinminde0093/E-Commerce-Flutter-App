// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:e_commerce_app/constants/utils.dart';
import 'package:e_commerce_app/models/products.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/error_handling.dart';
import '../../../constants/globalvariables.dart';

class SearchService {
  Future<List<Product>> search(String searchparam, BuildContext context) async {
    List<Product> products = [];

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth-token');

// token is null give error

      http.Response res = await http.get(
        Uri.parse("${uri}api/search/$searchparam"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'auth-token': token ?? '',
        },
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              products.add(
                Product.fromJson(
                  jsonEncode(jsonDecode(res.body)[i]),
                ),
              );
            }
          });
    } catch (err) {
      showSnackBar(context, "searchService:$err");
    }

    return products;
  }
}
