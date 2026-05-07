import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubits/cubit_category/cubit/cubit_category_cubit.dart';
import 'package:flutter_application_1/features/category/widgets/shimmer/shimmer_categort.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // استخدم BlocBuilder أو BlocConsumer هنا
    return BlocBuilder<CubitCategoryCubit, CubitCategoryState>(
      builder: (context, state) {
        if (state is categoryLoading) {
          // ✅ صح: رجعنا SliverToBoxAdapter عشان إحنا جوه CustomScrollView
          return  SliverGrid(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 0.8,
    ),
    delegate: SliverChildBuilderDelegate(
      (context, index) {
        return ShimmerItem();
      },
      childCount: 6, // نفس عدد العناصر اللي بتعرضها
    ),
  );
        }

        if (state is categoryError) {
           return const SliverToBoxAdapter(
            child: Center(child: Text("حدث خطأ ما")),
          );
        }

        final categories = context.read<CubitCategoryCubit>().categories;

        // ✅ صح: SliverGrid هو Sliver Widget أصلي
        return SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final category = categories[index];
              return Column(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(category.image ?? ""),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category.name ?? "",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              );
            },
            childCount: categories.length > 6 ? 6 : categories.length,
          ),
        );
      },
    );
  }
}




// BlocBuilder<CategoryCubit, CategoryState>(
//   builder: (context, state) {
//     if (state is CategoryLoading) {
//       return CircularProgressIndicator();
//     }
//   }
//     final categories = context.read<CategoryCubit>().categories;

//     return GridView.builder(
//       itemCount: categories.length,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//       ),
//       itemBuilder: (context, index) {
//         final category = categories[index];

//         return Column(
//           children: [
//             Image.network(category.image),
//             Text(category.name),
//           ],
//         );
//       },
//     );
//   },
// );














