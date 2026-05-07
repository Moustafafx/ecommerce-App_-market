import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubits/brand_cubit/Brand_State.dart';
import 'package:flutter_application_1/cubits/brand_cubit/brand_cubit.dart';
import 'package:flutter_application_1/features/brands/data/brand_model.dart';
import 'package:flutter_application_1/features/brands/shemmer/brands_shimmer.dart';
import 'package:flutter_application_1/features/brands/widgets/coustombrands.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class brands extends StatelessWidget {
  const brands({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrandCubit, BrandState>(
      builder: (context, state) {
        if (state is Brandloading) {
          return BrandShimmer();
        } else if (state is Brandsuccess) {
          final List<BrandModel> brands = state.brands;
          return SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: brands.take(3).length,
              itemBuilder: (context, index) {
                return coustombrands(brands: brands[index], );
              },
            ),
          );
        } else if (state is Brandfailer) {
          return Text(state.errormessag);
        }
        return SizedBox();
      },
    );
  }
}


