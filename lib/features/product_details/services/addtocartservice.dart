import 'dart:convert';

import 'package:e_commerce_app/constants/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/error_handling.dart';
import '../../../constants/globalvariables.dart';

class ProductServices {
  void rateProduct(BuildContext context, String id, double rating) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var token = prefs.getString('auth-token');

      http.Response res = await http.post(Uri.parse("$uri/api/rate-product"),
          body: jsonEncode({'id': id, 'rating': rating}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'auth-token': token??""
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            debugPrint("usccess");
          });
    } catch (err) {
      showSnackBar(context, "rateproduct: $err");
    }
  }

  void addToCart(final id, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString('auth-token');
      debugPrint(token);

      http.Response res = await http.post(Uri.parse("$uri/api/add-to-cart"),
          body: jsonEncode({'id': id}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'auth-token': token??""
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            debugPrint("usccess");
          });
    } catch (err) {
      showSnackBar(context, "rateproduct: $err");
    }
  }
}
