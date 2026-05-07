import 'package:flutter_application_1/core/network/api_consumer.dart';
import 'package:flutter_application_1/core/network/api_endpoints.dart';
import 'package:flutter_application_1/cubits/brand_cubit/Brand_State.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/features/brands/data/brand_model.dart';



class BrandCubit extends Cubit<BrandState> {
  BrandCubit(this.api) : super(Brandinitial());

  final ApiConsumer api;

  List<BrandModel> brands = [];

  Future<void> getBrands() async {
    try {
      emit(Brandloading());

      final response = await api.get(ApiEndpoints.brands); 
      // غير 'brands' لو ال endpoint مختلف

      brands = List<BrandModel>.from(
        response['list'].map((e) => BrandModel.fromJson(e)),
      );

      emit(Brandsuccess(brands));
    } catch (e) {
      emit(Brandfailer(e.toString()));
    }
  }
}