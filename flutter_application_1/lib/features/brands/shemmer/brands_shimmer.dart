import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BrandShimmer extends StatelessWidget {
  const BrandShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(right: 26, left: 10),
            width: 100,
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[300], // بدل الأبيض
    borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}