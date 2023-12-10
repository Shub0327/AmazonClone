import 'package:amazon_clone/constants/global_variables.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String text;
  VoidCallback onTap;
  CustomButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          backgroundColor: GlobalVariables.secondaryColor,
          minimumSize: const Size(double.infinity, 50)),
      child: Text(text),
    );
  }
}
