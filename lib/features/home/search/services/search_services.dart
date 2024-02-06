// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/util.dart';
import 'package:amazon_clone/features/auth/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SearchServices {
  Future<List<Product>> fetchSearchQueryResult({
    required String searchQuery,
    required BuildContext context,
  }) async {
    List<Product> listproduct = [];
    final userprovider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/products/search/$searchQuery'),
        headers: {
          'Content-Type': 'application/json ; charset=UTF-8 ',
          'x-auth-token': userprovider.user.token
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
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return listproduct;
  }
}
