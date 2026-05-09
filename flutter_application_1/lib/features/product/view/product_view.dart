import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/cubits/favourite/favourite_cubit.dart';
import 'package:flutter_application_1/cubits/favourite/favourite_states.dart';
import 'package:flutter_application_1/cubits/product_cubit/popular_product_cubit.dart'
    show
        PopularProductCubit,
        PopularProductState,
        PopularProductloading,
        PopularProductfailer,
        PopularProductsuccess;
import 'package:flutter_application_1/features/cart/view/cart_view.dart';
import 'package:flutter_application_1/features/product/widget/shemmer/product_shemmer.dart';
import 'package:flutter_application_1/features/shared/coustomtext.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/Cart_cubit/cart_cubit.dart';

// ✅ غيرنا من StatelessWidget لـ StatefulWidget عشان نحتاج cartKey و runAddToCartAnimation
class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  // ✅ مفتاح أيقونة الكارت
  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();

  // ✅ الفانكشن بتاعة الأنيميشن
  late Function(GlobalKey) runAddToCartAnimation;

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

          return AddToCartAnimation(
            cartKey: cartKey,
            height: 30,
            width: 30,
            opacity: 0.85,
            // ✅ جيب الفانكشن
            createAddToCartAnimation: (runAnimation) {
              runAddToCartAnimation = runAnimation;
            },
            child: Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    const SizedBox(width: 270),
                    // ✅ استبدلنا CircleAvatar بـ AddToCartIcon
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => CartView()),
                        );
                      },
                      child: AddToCartIcon(
                        key: cartKey,
                        icon: Icon(
                          Icons.shopping_cart_outlined,
                          color: AppColors.colorbluebutton,
                          size: 27,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              body: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 1,
                  crossAxisCount: 2,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];

                  // ✅ key لكل صورة منتج عشان الأنيميشن تبدأ منها
                  final GlobalKey imageKey = GlobalKey();

                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      width: 200,
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(11),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.colorbluebutton.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 11,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // الصورة مع زر المفضلة
                          Stack(
                            children: [
                              Container(
                                key: imageKey, // ✅ الـ key على الصورة
                                height: 115,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE0E9FF),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: Image.network(
                                    product.imageproduct,
                                    height: 140,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),

                              // زر المفضلة
                              Positioned(
                                top: 5,
                                right: 7,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: BlocBuilder<FavoriteCubit,
                                      FavoriteState>(
                                    builder: (context, state) {
                                      final isFav = context
                                          .read<FavoriteCubit>()
                                          .favoriteIds
                                          .contains(product.id);

                                      return GestureDetector(
                                        onTap: () {
                                          context
                                              .read<FavoriteCubit>()
                                              .toggleFavorite(
                                                product.id!,
                                                productData: {
                                                  "id": product.id,
                                                  "title": product.nameproduct,
                                                  "price": product.price,
                                                  "rating": product.rating,
                                                  "thumbnail":
                                                      product.imageproduct,
                                                },
                                              );
                                        },
                                        child: Icon(
                                          isFav
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: isFav
                                              ? Colors.red
                                              : Colors.grey,
                                          size: 20,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 2),

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
                                  const Icon(
                                    Icons.star_border,
                                    color: Color(0xFF0D1B3E),
                                    size: 20,
                                  ),
                                  coustomtext(
                                    text: product.rating.toString(),
                                    color: Colors.black,
                                    fontSize: 16,
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

                          // زر Add
                          Center(
                            child: GestureDetector(
                              onTap: () async {
                                // ✅ 1. شغل الأنيميشن من الصورة
                                await runAddToCartAnimation(imageKey);
                                // ✅ 2. أضف للكارت
                                if (context.mounted) {
                                  context
                                      .read<CartCubit>()
                                      .addToCart(product.id!);
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 30,
                                width: 130,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: AppColors.colorbluebutton,
                                  ),
                                ),
                                child: coustomtext(
                                  text: "Add",
                                  fontSize: 20,
                                  color: AppColors.colorbluebutton,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}