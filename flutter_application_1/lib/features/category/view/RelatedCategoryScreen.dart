import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/cubits/Cart_cubit/cart_cubit.dart'
    show CartCubit;
import 'package:flutter_application_1/cubits/RelatedcategoryCubit/cubit/related_category_cubit_cubit.dart';
import 'package:flutter_application_1/cubits/favourite/favourite_cubit.dart';
import 'package:flutter_application_1/cubits/favourite/favourite_states.dart';
import 'package:flutter_application_1/features/cart/view/cart_view.dart';
import 'package:flutter_application_1/features/category/view/details_view_category.dart';
import 'package:flutter_application_1/features/category/widgets/shimmer/shimmer_RelatedCategoryScreen.dart';
import 'package:flutter_application_1/features/shared/coustomtext.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Relatedcategoryscreen extends StatefulWidget {
  final String url;
  final String appbarname;

  const Relatedcategoryscreen({
    super.key,
    required this.url,
    required this.appbarname,
  });

  @override
  State<Relatedcategoryscreen> createState() => _RelatedcategoryscreenState();
}

class _RelatedcategoryscreenState extends State<Relatedcategoryscreen> {
  // ✅ مفتاح أيقونة الكارت
  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();

  // ✅ الفانكشن بتاعة الأنيميشن
  late Function(GlobalKey) runAddToCartAnimation;

  @override
  void initState() {
    super.initState();
    context.read<RelatedCategoryCubitCubit>().getRelatedcategoryCubit(
          widget.url,
        );
  }

  @override
  Widget build(BuildContext context) {
    return AddToCartAnimation(
  cartKey: cartKey,
  height: 30,
  width: 30,
  opacity: 0.85,
  createAddToCartAnimation: (runAnimation) {
    runAddToCartAnimation = runAnimation;
  },
      child: Scaffold(
        appBar: AppBar(
          leading: Row(
            children: [
              const SizedBox(width: 11),
              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: const Color(0xffCADCFF), width: 2),
                ),
                child: Center(
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_ios_new, size: 25),
                  ),
                ),
              ),
            ],
          ),
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 11),

              coustomtext(text: widget.appbarname),

              // ✅ استبدلنا CircleAvatar بـ AddToCartIcon
// ✅ وكمان AddToCartIcon
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
),          ],
          ),
        ),
        body: BlocBuilder<RelatedCategoryCubitCubit, RelatedProductsCubitState>(
          builder: (context, state) {
            if (state is RelatedCategoryCubitLoading) {
              return ShimmerRelatedcategoryscreen();
            }

            if (state is RelatedCategoryCubitErrorl) {
              return Center(child: Text(state.errormessag));
            }

            if (state is RelatedCategoryCubitSuccess) {
              final products =
                  context.read<RelatedCategoryCubitCubit>().products;

              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];

                    // ✅ key لكل صورة منتج عشان الأنيميشن تبدأ منها
                    final GlobalKey imageKey = GlobalKey();

                    return OpenContainer(
                      transitionDuration: const Duration(milliseconds: 500),
                      closedElevation: 0,
                      openElevation: 0,
                      closedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),

                      closedBuilder: (context, action) {
                        return Container(
                          color: Theme.of(context).cardColor,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ✅ حطينا الـ key على الصورة
                              Container(
                                key: imageKey,
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Image.network(product.thumbnail!),
                              ),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          product.title!,
                                          maxLines: 2,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF0D214F),
                                          ),
                                        ),

                                        // زر المفضلة
                                        BlocBuilder<FavoriteCubit,
                                            FavoriteState>(
                                          builder: (context, state) {
                                            final isFav = context
                                                .read<FavoriteCubit>()
                                                .favoriteIds
                                                .contains(product.id);
                                            return GestureDetector(
                                              onTap: () {
                                                if (product.id != null) {
                                                  context
                                                      .read<FavoriteCubit>()
                                                      .toggleFavorite(
                                                        product.id!,
                                                        productData: {
                                                          'id': product.id,
                                                          'title': product.title,
                                                          'price': product.price,
                                                          'thumbnail':
                                                              product.thumbnail,
                                                          'rating':
                                                              product.rating,
                                                        },
                                                      );
                                                }
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
                                      ],
                                    ),

                                    const SizedBox(height: 8),

                                    Row(
                                      children: [
                                        const Icon(Icons.access_time,
                                            size: 16, color: Colors.blue),
                                        const SizedBox(width: 4),
                                        coustomtext(
                                          text: product.shippingInformation!,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 8),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        coustomtext(
                                          text: 'Price:${product.price}',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.star_border,
                                                size: 20),
                                            Text(product.rating.toString()),
                                          ],
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 12),

                                    SizedBox(
                                      width: double.infinity,
                                      child: OutlinedButton(
                                        onPressed: () async {
                                          // ✅ 1. شغل الأنيميشن من الصورة
                                          await runAddToCartAnimation(imageKey);
                                          // ✅ 2. أضف للكارت
                                          if (context.mounted) {
                                            context
                                                .read<CartCubit>()
                                                .addToCart(product.id!);
                                          }
                                        },
                                        style: OutlinedButton.styleFrom(
                                          side: const BorderSide(
                                            color: Colors.blue,
                                            width: 1.5,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12),
                                        ),
                                        child: const Text(
                                          'Add',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ),

                                    const Divider(height: 10),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },

                      openBuilder: (context, action) {
                        return DetailsViewCategory(
                          title: product.title!,
                          images: product.images!,
                          description: product.description!,
                          price: product.price!,
                          rating: product.rating!,
                        );
                      },
                    );
                  },
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}