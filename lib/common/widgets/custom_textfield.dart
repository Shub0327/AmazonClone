import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hinttext;
  final int maxline;

  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hinttext,
      this.maxline = 1});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hinttext,
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38)),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your $hinttext';
        }
        return null;
      },
      maxLines: maxline,
    );
  }
}
