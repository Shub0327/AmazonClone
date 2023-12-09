import 'package:amazon_clone/constants/global_variables.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Carousel extends StatelessWidget {
  const Carousel({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: GlobalVariables.carouselImages.map((i) {
          return Builder(builder: (BuildContext context) {
            return Image.network(
              i,
              fit: BoxFit.cover,
              height: 200,
            );
          });
        }).toList(),
        options: CarouselOptions(
          viewportFraction: 1, autoPlay: true,
          aspectRatio: 2.0, // enlargeCenterPage: true,
          // enlargeStrategy: CenterPageEnlargeStrategy.height,
        ));
  }
}
