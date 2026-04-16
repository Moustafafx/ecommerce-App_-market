import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MyCarousel extends StatelessWidget {
  final List<String> images = [
    "assets/images/Offer_1.png",
    "assets/images/Offer_1.png",
    "assets/images/Offer_1.png",
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 140,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.9,
      ),
      items: images.map((url) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(13),
          child: Image.asset(url, fit: BoxFit.cover, width: double.infinity),
        );
      }).toList(),
    );
  }
}
