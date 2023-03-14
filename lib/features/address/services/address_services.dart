import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../constants/error_handling.dart';
import '../../../constants/globalvariables.dart';
import '../../../constants/utils.dart';
import '../../../models/products.dart';
import '../../../models/user.dart';
import '../../../provider/user_provider.dart';

class AddressServices {
  void saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('${uri}api/save-user-address'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'address': address,
        }),
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user = userProvider.user.copyWith(
            address: jsonDecode(res.body)['address'],
          );

          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // get all the products
  void placeOrder({
    required BuildContext context,
    required String address,
    required double totalSum,
  }) async {
    debugPrint("placed order");
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse('${uri}api/order'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'auth-token': userProvider.user.token,
          },
          body: jsonEncode({
            'cart': userProvider.user.cart,
            'address': address,
            'totalPrice': totalSum,
          }));

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Your order has been placed!');
          User user = userProvider.user.copyWith(
            cart: [],
          );
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('${uri}admin/delete-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          onSuccess();
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
