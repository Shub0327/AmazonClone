import 'dart:io';

import 'package:amazon_clone/common/widgets/custom_buttom.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/util.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  static const String routeName = '/add_product';
  AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String category = 'Mobiles';

  List<String> itemList = [
    'Mobiles',
    'Essentials',
    'Appliances', // Corrected typo
    'Books',
    'Fashion',
  ];

  //files to be uploaded
  List<File> images = [];
  selecImages() async {
    var res = await pickImage();
    setState(() {
      images = res;
    });
  }

  TextEditingController productNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  @override
  void dispose() {
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: const Padding(
            padding: EdgeInsets.only(left: 60),
            child: Text(
              'Add Product',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                images.isNotEmpty
                    ? CarouselSlider(
                        items: images.map((i) {
                          return Builder(builder: (BuildContext context) {
                            return Image.file(
                              i,
                              fit: BoxFit.cover,
                              height: 200,
                            );
                          });
                        }).toList(),
                        options: CarouselOptions(
                          viewportFraction: 1,
                          autoPlay: true,
                          aspectRatio: 2.0,
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                        ))
                    : GestureDetector(
                        onTap: selecImages,
                        child: DottedBorder(
                          radius: const Radius.circular(10),
                          strokeCap: StrokeCap.round,
                          dashPattern: const [10, 4],
                          borderType: BorderType.RRect,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.folder_open_outlined,
                                    size: 40),
                                const SizedBox(height: 10),
                                Text(
                                  'Select Product Image',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey.shade400),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextField(
                    controller: productNameController,
                    hinttext: 'Product Name'),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                    controller: descriptionController,
                    hinttext: 'Product Description',
                    maxline: 7),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                    controller: priceController, hinttext: 'Product Price'),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: quantityController,
                  hinttext: 'Quantity Available',
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: category,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: itemList.map(
                      (String e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        );
                      },
                    ).toList(),
                    onChanged: (String? value) {
                      if (value != null) {
                        setState(() {
                          category = value;
                        });
                      }
                    },
                  ),
                ),
                CustomButton(text: 'Sell', onTap: () {}),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
