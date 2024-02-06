// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/util.dart';

import 'package:amazon_clone/features/auth/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AdminServices {
  sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);

    try {
      debugPrint('Uploading images');

      final cloudinary = CloudinaryPublic('dhmmdnev5', 'zhabjlf6');
      List<String> imageUrls = [];
      for (int i = 0; i < images.length; i++) {
        var response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrls.add(response.secureUrl.toString());
      }
      debugPrint('Images uploaded');
      Product product = Product(
        name: name,
        description: description,
        price: price,
        quantity: quantity,
        category: category,
        images: imageUrls,
      );
      debugPrint('Product: ${product.toJson()}');

      http.Response res = await http.post(Uri.parse('$uri/admin/add-product'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8 ',
            'x-auth-token': userprovider.user.token
          },
          body: product.toJson());

      debugPrint('Response: ${res.body}');

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Product added successfully');
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Product>> getProduct({required BuildContext context}) async {
    List<Product> listproduct = [];

    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/products'),
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

  deleteProduct({required BuildContext context, required String id}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.delete(
        Uri.parse('$uri/admin/delete-product/$id'),
        headers: {
          'Content-Type': 'application/json ; charset=UTF-8 ',
          'x-auth-token': userProvider.user.token
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Product deleted successfully');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
