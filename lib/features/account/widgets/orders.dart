import 'package:amazon_clone/constants/global_variables.dart';
import 'package:flutter/material.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    List list = [];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(
                left: 15,
              ),
              child: Text(
                'Your Order\'s',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 15,
              ),
              child: Text(
                'See More',
                style: TextStyle(
                    fontSize: 15, color: GlobalVariables.selectedNavBarColor),
              ),
            ),
          ],
        ),
        //display orders
        Container(
          padding: const EdgeInsets.only(left: 10, right: 0, top: 20),
          height: 170,
          child:
              ListView.builder(itemBuilder: (context, index) {}, itemCount: 5),
        ),
      ],
    );
  }
}
