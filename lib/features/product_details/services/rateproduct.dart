import 'dart:convert';

import 'package:e_commerce_app/constants/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/globalvariables.dart';

class ProductServices {
  void rateProduct(BuildContext context, String id, double rating) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var token = prefs.getString('auth-token');

      await http.post(Uri.parse("$uri/api/rate-product"),
          body: jsonEncode({'id': id, 'rating': rating}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'auth-token': token!
          });
    } catch (err) {
      showSnackBar(context, "rateproduct: $err");
    }
  }
}
