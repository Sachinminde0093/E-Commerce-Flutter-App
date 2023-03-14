// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'dart:convert';

import 'package:e_commerce_app/constants/utils.dart';
import 'package:e_commerce_app/models/user.dart';
import 'package:e_commerce_app/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/error_handling.dart';
import '../../../constants/globalvariables.dart';

class ProductDetailServices {
  void rateProduct(BuildContext context, String id, double rating) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var token = prefs.getString('auth-token');

      http.Response res = await http.post(Uri.parse("${uri}api/rate-product"),
          body: jsonEncode({'id': id, 'rating': rating}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'auth-token': token ?? ""
          });

      httpErrorHandle(response: res, context: context, onSuccess: () {});
    } catch (err) {
      showSnackBar(context, "rateproduct: $err");
    }
  }

  void addToCart(final id, BuildContext context) async {
    // ignore: duplicate_ignore, duplicate_ignore
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString('auth-token');

      http.Response res = await http.post(Uri.parse("${uri}api/add-to-cart"),
          body: jsonEncode({'id': id}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'auth-token': token ?? ""
          });

      // ignore: use_build_context_synchronously

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user =
              userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
          userProvider.setUserFromModel(user);
        },
      );
    } catch (err) {
      showSnackBar(context, "rateproduct: $err");
    }
  }
}
