import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubits/brand_cubit/Brand_State.dart';
import 'package:flutter_application_1/cubits/brand_cubit/brand_cubit.dart';
import 'package:flutter_application_1/features/brands/data/brand_model.dart';
import 'package:flutter_application_1/features/brands/widgets/coustombrands.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewallBrands extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Brands")),
      body: BlocBuilder<BrandCubit, BrandState>(
        builder: (context, state) {
          if (state is Brandloading) {
            return CircularProgressIndicator();
          } else if (state is Brandsuccess) {
            final List<BrandModel> brands = state.brands;
            return GridView.builder(
              itemCount: brands.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 20,
                crossAxisSpacing: 3,
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return coustombrands(brands: brands[index]);
              },
            );
          } else if (state is Brandfailer) {
            return Text(state.errormessag);
          }

          return SizedBox();
        },
      ),
    );
  }
}
