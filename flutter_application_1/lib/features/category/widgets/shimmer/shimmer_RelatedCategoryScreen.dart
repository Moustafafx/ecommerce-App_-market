import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerRelatedcategoryscreen extends StatelessWidget {
  const ShimmerRelatedcategoryscreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // شيمر مكان صورة المنتج
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 16),
            
            // شيمر مكان تفاصيل المنتج
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // شيمر مكان العنوان والأيقونة
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 120,
                        height: 16,
                        color: Colors.white,
                      ),
                      Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  // شيمر مكان الوصف (fdfvdf)
                  Container(
                    width: 80,
                    height: 14,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 12),
                  
                  // شيمر مكان وقت التوصيل
                  Row(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 100,
                        height: 12,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  
                  // شيمر مكان السعر والتقييم
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 70,
                        height: 16,
                        color: Colors.white,
                      ),
                      Container(
                        width: 40,
                        height: 16,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // شيمر مكان زر Add
                  Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}