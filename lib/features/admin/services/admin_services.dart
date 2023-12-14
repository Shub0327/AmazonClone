import 'dart:io';

import 'package:amazon_clone/constants/util.dart';
import 'package:amazon_clone/features/auth/models/product.dart';
import 'package:cloudinary/cloudinary.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';

class AdminServices {
  sellProduct(
      {required BuildContext context,
      required String name,
      required String description,
      required double price,
      required double quantity,
      required String category,
      required List<File> images}) async {
    try {
      final cloudinary = CloudinaryPublic('dhmmdnev5', 'zhabjlf6');
      List<String> imageUrls = [];
      for (int i = 0; i < images.length; i++) {
        var response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrls.add(response.secureUrl.toString());

        Product product = Product(
            name: name,
            description: description,
            price: price,
            quantity: quantity,
            category: category,
            images: imageUrls);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
