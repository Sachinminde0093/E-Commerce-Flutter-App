import 'dart:convert';

import 'package:e_commerce_app/provider/userprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/error_handling.dart';
import '../../../constants/globalvariables.dart';
import '../../../constants/utils.dart';
import 'package:http/http.dart' as http;

import '../../../models/user.dart';

class CartServices {
  void removeFromCart(final id, BuildContext context) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString('auth-token');
      debugPrint(token);

      http.Response res = await http.delete(
          Uri.parse('$uri/api/remove-from-cart/$id'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'auth-token': token!
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            User user =
                userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
            userProvider.setUserFromModel(user);
          });
    } catch (err) {
      showSnackBar(context, "rateproduct: $err");
    }
  }
}
