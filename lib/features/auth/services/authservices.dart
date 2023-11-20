import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/util.dart';
import 'package:amazon_clone/features/auth/models/user.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  //sign up user

  void signUpUser(
      {required BuildContext context,
      required String name,
      required String email,
      required String password}) async {
    try {
      User user = User(
          id: '',
          name: name,
          password: password,
          address: '',
          token: '',
          type: '',
          email: email);

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, "User Signed In Succesfully, now log in ");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
