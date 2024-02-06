// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/util.dart';
import 'package:amazon_clone/features/auth/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomeServices {
  Future<List<Product>> fetchCategroyProducts(
      {required BuildContext context, required String category}) async {
    List<Product> listproduct = [];

    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/products?category=$category'),
        headers: {
          'Content-Type': 'application/json ; charset=UTF-8 ',
          'x-auth-token': userProvider.user.token
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            debugPrint('Response: ${res.body}');

            if (res.statusCode == 200) {
              for (int i = 0; i < jsonDecode(res.body).length; i++) {
                listproduct.add(
                  Product.fromJson(jsonEncode(jsonDecode(res.body)[i])),
                );
              }

              // Now you have a list of Product objects in `listproduct`
            }
          });
    } catch (e) {
      debugPrint('Error: $e');
      showSnackBar(context, e.toString());
    }
    return listproduct;
  }

  static void fetchCategroy(
      {required BuildContext context, required String category}) {}
}
