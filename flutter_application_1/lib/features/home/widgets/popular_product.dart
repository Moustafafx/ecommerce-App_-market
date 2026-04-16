import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/features/shared/coustomtext.dart';

class popular_product extends StatelessWidget {
  const popular_product({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, // ضروري تحدد ارتفاع هنا
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // السكرول الأفقي
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(7.0),
            child: Container(
              width: 205, // يمكنك التحكم في العرض حسب احتياجك
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(11),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.colorbluebutton.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 11,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // الجزء العلوي: الصورة مع زر المفضلة
                  Stack(
                    children: [
                      Container(
                        height: 115,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFFE0E9FF,
                          ), // لون الخلفية الفاتح
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/images/iPhone_11_Pro.png', // رابط صورة الموبايل
                            height: 140,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 5,
                        right: 7,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.favorite_border,
                            color: Color(0xFF0D1B3E),
                            size: 21,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // السعر والتقييم
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const coustomtext(
                        text: "19999 LE",
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
    
                      Row(
                        children: const [
                          Icon(
                            Icons.star_border,
                            color: Color(0xFF0D1B3E),
                            size: 27,
                          ),
                          SizedBox(width: 4),
    
                          coustomtext(
                            text: "4.9",
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ],
                  ),
    
                  // اسم المنتج
                  const coustomtext(
                    text: "iPhone 11 Pro",
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}