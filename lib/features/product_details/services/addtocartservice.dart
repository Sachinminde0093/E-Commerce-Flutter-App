import 'dart:convert';

import 'package:e_commerce_app/constants/error_handling.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/globalvariables.dart';

class AddToCartService {
  void addToCart(final id, BuildContext context) async {

    
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('auth-token');

    http.Response res = await http.post(Uri.parse("$uri/api/add-to-cart"),
        body: jsonEncode({'id': id}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          debugPrint("usccess");
        });
  }
}
