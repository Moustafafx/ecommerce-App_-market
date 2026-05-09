import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/cache/shared_preferences_cache.dart';
import 'package:flutter_application_1/cubits/searchin_home/cubit/search_cubit.dart';
import 'package:flutter_application_1/features/brands/view/brand_inhome.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/features/auth/view/profile_view.dart';
import 'package:flutter_application_1/features/brands/view/viewall_brands.dart';
import 'package:flutter_application_1/features/category/view/details_view_category.dart';
import 'package:flutter_application_1/features/category/view/viewall_category.dart';
import 'package:flutter_application_1/features/product/view/product_view.dart';
import 'package:flutter_application_1/features/product/widget/Definition_of_part.dart';
import 'package:flutter_application_1/features/home/widgets/carousel_slider.dart';
import 'package:flutter_application_1/features/home/widgets/category.dart';
import 'package:flutter_application_1/features/product/view/popular_product.dart';
import 'package:flutter_application_1/features/shared/coustomtext.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final name = SharedPreferencesCache.getdata(key: "name") ?? "مستخدم";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 77,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => ProfileView()));
              },
              child: Builder(
                builder: (context) {
                  final imagePath = SharedPreferencesCache.getdata(
                    key: "profile_image",
                  );
                  return CircleAvatar(
                    radius: 29,
                    backgroundImage: imagePath != null
                        ? FileImage(File(imagePath))
                        : const NetworkImage(
                                "https://p1.hiclipart.com/preview/666/472/877/person-user-profile-avatar-logo-blackandwhite-symbol-circle-png-clipart.jpg",
                              )
                              as ImageProvider,
                  );
                },
              ),
            ),
            SizedBox(width: 15),
            coustomtext(
              text: "Hi $name !",
              fontSize: 21,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Column(
          children: [
            // ✅ حقل البحث
            TextField(
              controller: _searchController,
              onChanged: (value) {
                context.read<SearchCubit>().onSearchChanged(value);
              },
              decoration: InputDecoration(
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, state) {
                      // ✅ لو بيبحث، دايرة تحميل
                      if (state is SearchLoading) {
                        return const Padding(
                          padding: EdgeInsets.all(12),
                          child: CircularProgressIndicator(strokeWidth: 2),
                        );
                      }
                      // ✅ لو في نص، زرار مسح
                      if (_searchController.text.isNotEmpty) {
                        return IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            context.read<SearchCubit>().onSearchChanged("");
                          },
                        );
                      }
                      // ✅ الأيقونة الافتراضية
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: AppColors.colorbluebutton,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Icon(Icons.format_list_bulleted_outlined),
                      );
                    },
                  ),
                ),
                prefixIcon: const Icon(Icons.search_rounded, size: 37),
                hintText: "What are you looking for?",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),

            SizedBox(height: 15),

            // ✅ هنا القرار: نتايج بحث ولا المحتوى العادي
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  // ✅ لو المستخدم بيكتب، ورّي النتايج
                  if (state is SearchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is SearchEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/Illustration_Search_Not_Found.png',
                            height: 300,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 10),
                          const coustomtext(
                            text: "Oops Not Found!",
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is SearchError) {
                    return Center(child: Text(state.error));
                  }

                  if (state is SearchSuccess) {
                    return ListView.builder(
                      itemCount: state.results.length,
                      itemBuilder: (context, index) {
                        final item =
                            state.results[index] as Map<String, dynamic>;
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DetailsViewCategory(
                                  title: item['title']?.toString() ?? "",
                                  description:
                                      item['description']?.toString() ?? "",
                                  price:
                                      (item['price'] as num?)?.toDouble() ??
                                      0.0,
                                  rating:
                                      (item['rating'] as num?)?.toDouble() ??
                                      0.0,
                                  images:
                                      item['images'] as List? ??
                                      [
                                        item['thumbnail'] ?? "",
                                      ], // ✅ fallback لو مفيش images
                                ),
                              ),
                            );
                          },
                          child: ListTile(
                            leading: item['thumbnail'] != null
                                ? Image.network(
                                    item['thumbnail'].toString(),
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                        const Icon(Icons.image_not_supported),
                                  )
                                : const Icon(Icons.image_not_supported),
                            title: Text(item['title']?.toString() ?? ""),
                            subtitle: Text(
                              "\$${item['price']?.toString() ?? '0'}",
                            ),
                            trailing: item['brand'] != null
                                ? Text(item['brand'].toString())
                                : null,
                          ),
                        );
                      },
                    );
                  }

                  // ✅ المحتوى الافتراضي (قبل ما يبحث)
                  return CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(child: MyCarousel()),
                      SliverToBoxAdapter(child: SizedBox(height: 15)),
                      SliverToBoxAdapter(
                        child: Definition_of_part(
                          namedescription: 'Popular Product',
                          ontap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => ProductView()),
                            );
                          },
                        ),
                      ),
                      SliverToBoxAdapter(child: popular_product()),
                      SliverToBoxAdapter(
                        child: Definition_of_part(
                          namedescription: 'Category',
                          ontap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ViewallCategory(),
                              ),
                            );
                          },
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        sliver: CategoryWidget(),
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: 15)),
                      SliverToBoxAdapter(
                        child: Definition_of_part(
                          namedescription: 'Brands',
                          ontap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ViewallBrands(),
                              ),
                            );
                          },
                        ),
                      ),
                      SliverToBoxAdapter(child: brands()),
                      
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
