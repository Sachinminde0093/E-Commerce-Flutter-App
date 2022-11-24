import 'dart:convert';
import 'package:e_commerce_app/constants/error_handling.dart';
import 'package:e_commerce_app/constants/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/globalvariables.dart';
import '../../../models/user.dart';

class AuthService {
  void signUpUser(
      {required BuildContext context,
      required String email,
      required String password,
      required String name}) async {
    try {
      User user = User(
        id: '',
        name: name,
        password: password,
        email: email,
        address: '',
        type: '',
        token: '',
      );

      http.Response res = await http.post(
        Uri.parse("$uri/api/signup"),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () => {
                showSnackBar(context, 'Account Has been created Successfully.'),
              });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser(
      {required BuildContext context,
      required String email,
      required String password}) async {
    print(email + password);
    try {
      http.Response res = await http.post(Uri.parse("$uri/api/signin"),
          body: jsonEncode({'email': email, 'password': password}),
          headers: <String, String>{
            'Content-type': 'application/json; charset=UTF-8'
          });

      print(res.body.toString());

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            showSnackBar(context, "user login successful");
          });
    } catch (e) {
      showSnackBar(context, e.toString() + "error");
    }
  }
}
