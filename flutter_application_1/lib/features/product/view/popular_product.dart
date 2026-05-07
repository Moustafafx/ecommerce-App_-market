import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/cubits/favourite/favourite_cubit.dart';
import 'package:flutter_application_1/cubits/favourite/favourite_states.dart';
import 'package:flutter_application_1/cubits/product_cubit/popular_product_cubit.dart';
import 'package:flutter_application_1/features/product/widget/shemmer/product_shemmer.dart';
import 'package:flutter_application_1/features/shared/coustomtext.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class popular_product extends StatelessWidget {

late List<int> favoriteIds;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularProductCubit, PopularProductState>(
      builder: (context, state) {
        if (state is PopularProductloading) {
          print("LOADING STATE TRIGGERED");
          return PopularProductShimmer();
        }
        if (state is PopularProductfailer) {
          return Center(child: Text(state.errormessag));
        }
        if (state is PopularProductsuccess) {
          final products = state.products;

          return SizedBox(
            height: 213, // ضروري تحدد ارتفاع هنا
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // السكرول الأفقي
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
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
                                child: Image.network(
                                  product.imageproduct, // رابط صورة الموبايل
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
                                child:BlocBuilder<FavoriteCubit, FavoriteState>(
  builder: (context, state) {
    // ✅ استخدم state مش context.read
    final isFav = context.read<FavoriteCubit>().favoriteIds.contains(product.id);
    
    return GestureDetector(
 onTap: () {
 context.read<FavoriteCubit>().toggleFavorite(
   product.id!,
   productData: {
     "id": product.id,
     "title": product.nameproduct,
     "price": product.price,
     "rating": product.rating,
     "thumbnail": product.imageproduct,
   },
 );
},
      child: Icon(
        isFav ? Icons.favorite : Icons.favorite_border,
        color: isFav ? Colors.red : Colors.grey, // ✅ بيتغير
        size: 20,
      ),
    );
  },
)
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        // السعر والتقييم
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            coustomtext(
                              text: "${product.price.toString()} LE",
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),

                            Row(
                              children: [
                                Icon(
                                  Icons.star_border,
                                  color: Color(0xFF0D1B3E),
                                  size: 27,
                                ),
                                SizedBox(width: 4),

                                coustomtext(
                                  text: product.rating.toString(),
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ],
                        ),

                        // اسم المنتج
                        coustomtext(
                          text: product.nameproduct,
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
