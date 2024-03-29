// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'dart:convert';

import 'package:e_commerce_app/constants/error_handling.dart';
import 'package:e_commerce_app/constants/globalvariables.dart';
import 'package:e_commerce_app/constants/utils.dart';
import 'package:e_commerce_app/features/home/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/widgets/botom_bar.dart';
import '../../../models/user.dart';
import '../../../provider/user_provider.dart';

class AuthService {
  void get() async {
    try {
      // ignore: empty_catches
    } catch (e) {}
  }

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
        cart: [],
      );

      http.Response res = await http.post(
        Uri.parse("${uri}api/signup"),
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
      showSnackBar(context, " signUp error$e");
    }
  }

  void signInUser(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      http.Response res = await http.post(Uri.parse("${uri}api/signin"),
          body: jsonEncode({'email': email, 'password': password}),
          headers: <String, String>{
            'Content-type': 'application/json; charset=UTF-8'
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();

            Provider.of<UserProvider>(context, listen: false).setUser(res.body);

            await prefs.setString("auth-token", jsonDecode(res.body)['token']);

            final type =
                Provider.of<UserProvider>(context, listen: false).user.type;

            (type == "user")
                ? Navigator.pushNamedAndRemoveUntil(
                    context, BottomBar.routeName, (route) => false,
                    arguments: Provider.of<UserProvider>(context, listen: false)
                        .user
                        .cart
                        .length)
                : Navigator.pushNamedAndRemoveUntil(
                    context,
                    HomeScreen.routeName,
                    (route) => false,
                  );

            showSnackBar(context, "user login successful");
          });
    } catch (e) {
      showSnackBar(context, "${e}error");
    }
  }

  void getUser(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString("auth-token");

      var tokenres = await http.post(Uri.parse("${uri}tokenisvalid"),
          headers: <String, String>{
            'Conteent-type': 'application/json; charset=UTF-8',
            'auth-token': token ?? ""
          });

      var isvalid = jsonDecode(tokenres.body);

      if (isvalid == true) {
        http.Response userRes = await http.get(Uri.parse(uri),
            headers: <String, String>{
              'Content-type': 'application/json; charset=UTF-8',
              'auth-token': token ?? ""
            });

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      debugPrint(e.toString());
      // showSnackBar(context, e.toString());
    }
  }
}
