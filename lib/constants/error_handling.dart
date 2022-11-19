import 'dart:convert';

import 'package:e_commerce_app/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHadle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(
          context, jsonDecode(response.body)['msg']); //need to decode json data
      break;
    case 500:
      showSnackBar(
          context, jsonDecode(response.body)['msg']); //need to decode json data
      break;
    default:
      showSnackBar(context, response.body); //need to decode json data
      break;
  }
}
