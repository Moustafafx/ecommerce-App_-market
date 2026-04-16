import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/core/network/dio_consumer.dart';
import 'package:flutter_application_1/cubits/cubit_category/cubit/cubit_category_cubit.dart';
import 'package:flutter_application_1/features/category/view/viewall_category.dart';

import 'package:flutter_application_1/features/home/widgets/Definition_of_part.dart';
import 'package:flutter_application_1/features/home/widgets/carousel_slider.dart';
import 'package:flutter_application_1/features/home/widgets/category.dart';
import 'package:flutter_application_1/features/home/widgets/popular_product.dart';
import 'package:flutter_application_1/features/shared/coustomtext.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorsinapp,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 77,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            CircleAvatar(
              radius: 33,
              backgroundImage: NetworkImage(
                "https://p1.hiclipart.com/preview/666/472/877/person-user-profile-avatar-logo-blackandwhite-symbol-circle-png-clipart.jpg",
              ),
            ),
            SizedBox(width: 15),
            coustomtext(
              text: "Hi moustafa !",
              fontSize: 21,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(7.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: TextField(
                decoration: InputDecoration(
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: AppColors.colorbluebutton,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(Icons.format_list_bulleted_outlined),
                    ),
                  ),
                  prefixIcon: Icon(Icons.search_rounded, size: 37),
                  hintText: "What are you looking for ? ",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 15)),

            SliverToBoxAdapter(child: MyCarousel()),
            SliverToBoxAdapter(child: SizedBox(height: 15)),

            SliverToBoxAdapter(
              child: Definition_of_part(
                namedescription: 'Popular Product',
                ontap: () {},
              ),
            ),
            SliverToBoxAdapter(child: popular_product()),

            /// 🔥 زر View All
            SliverToBoxAdapter(
              child: Definition_of_part(
                namedescription: 'Category',
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ViewallCategory()),
                  );
                },
              ),
            ),

            /// 🔥 الكاتيجوري (6 بس)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              sliver: CategoryWidget(),
            ),
          ],
        ),
      ),
    );
  }
}


















// class HomeView extends StatefulWidget {
//   @override
//   State<HomeView> createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   @override
//   Widget build(BuildContext context) {
//     // 1. التعديل الجوهري: تغليف الصفحة بالـ Providers
//     return MultiBlocProvider(
//       providers: [
//         // بننادي على الـ Cubit هنا ونخليه يبدأ يجيب البيانات فوراً
//         BlocProvider(create: (context) => CubitCategoryCubit()..getProducts()),
//         // لو عندك Cubit للمنتجات الـ Popular ضيفه هنا بنفس الطريقة
//       ],
//       child: Scaffold(
//         backgroundColor: AppColors.colorsinapp,
//         appBar: AppBar(
//            backgroundColor: Colors.transparent,
//         toolbarHeight: 77,
//         automaticallyImplyLeading: false,
//         title: Row(
//           children: [
//             CircleAvatar(
//               radius: 33,
//               backgroundImage: NetworkImage(
//                 "https://p1.hiclipart.com/preview/666/472/877/person-user-profile-avatar-logo-blackandwhite-symbol-circle-png-clipart.jpg",
//               ),
//             ),
//             SizedBox(width: 15),
//             coustomtext(
//               text: "Hi moustafa !",
//               fontSize: 21,
//               fontWeight: FontWeight.w500,
//             ),
//             SizedBox(width: 111),
//             IconButton(
//               iconSize: 37,
//               onPressed: () {},
//               icon: Icon(
//                 Icons.notifications_none_outlined,
//                 color: AppColors.colorbluebutton,
//               ),
//             ),
//           ],
//         ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(7.0),
//           child: CustomScrollView(
//             slivers: [
//               // Search Bar
//               SliverToBoxAdapter(
//                 child: TextField( /* ... كود البحث ... */ ),
//               ),

//               const SliverToBoxAdapter(child: SizedBox(height: 15)),
//               const SliverToBoxAdapter(child:MyCarousel),
//               const SliverToBoxAdapter(child: SizedBox(height: 15)),

//               SliverToBoxAdapter(
//                 child: Definition_of_part(namedescription: 'Popular Product'),
//               ),

//               // تأكد إن popular_product بترجع SliverToBoxAdapter أو استخدمها كدة:
//               SliverToBoxAdapter(child: popular_product()),

//               SliverToBoxAdapter(
//                 child: Definition_of_part(namedescription: 'Category'),
//               ),

//               // ✅ هنا الـ CategoryWidget هتشتغل صح لأن الـ Provider فوقها في الشجرة
//               // وهي أصلاً بترجع SliverGrid فمش محتاجة SliverToBoxAdapter
//               SliverPadding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 sliver: const CategoryWidget(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }









































