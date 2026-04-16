// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/cubits/cubit_category/cubit/cubit_category_cubit.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubits/cubit_category/cubit/cubit_category_cubit.dart';
import 'package:flutter_application_1/features/category/view/RelatedCategoryScreen.dart';
import 'package:flutter_application_1/features/category/widgets/shimmer/shimmerViewallCategory.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewallCategory extends StatelessWidget {
  const ViewallCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All Categories")),

      body: BlocBuilder<CubitCategoryCubit, CubitCategoryState>(
        builder: (context, state) {
          if (state is categoryLoading) {
            return const Center(child: CategoryShimmer());
          }

          if (state is categoryError) {
            return Center(child: Text(state.errormessag));
          }

          final categories = context.read<CubitCategoryCubit>().categories;

          return GridView.builder(
            itemCount: categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              final category = categories[index];
              return Column(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Relatedcategoryscreen(
                              url: category.url!,
                              appbarname: category.name!, // 👈 كده الصح
                            ),
                          ),
                        );
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
          );
        },
      ),
    );
  }
}
