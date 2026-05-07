import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/brands/data/brand_model.dart';
import 'package:flutter_application_1/features/shared/coustomtext.dart';

class coustombrands extends StatelessWidget {
  const coustombrands({super.key, required this.brands});

  final BrandModel brands;

  @override
  Widget build(BuildContext context) {
    return Container(
      
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black),
      ),
      margin: EdgeInsets.only(right: 26, left: 10),

      width: 100,
      child: Column(
        children: [
          Text(brands.emoji, style: TextStyle(fontSize: 45)),

          coustomtext(
            color: Colors.black,
            text: brands.name,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}
