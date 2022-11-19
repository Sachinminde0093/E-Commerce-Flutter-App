import 'package:e_commerce_app/constants/error_handling.dart';
import 'package:e_commerce_app/constants/utils.dart';
import 'package:http/http.dart' as http;

import '../../../constants/globalvariables.dart';
import '../../../models/user.dart';

class AuthService {
  void signUpUser(
      {required context,
      required String email,
      required password,
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
      );

      httpErrorHadle(
          response: res,
          context: context,
          onSuccess: () => {
                showSnackBar(context, 'Account Has been created Successfully.'),
              });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
