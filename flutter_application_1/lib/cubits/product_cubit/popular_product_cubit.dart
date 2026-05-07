import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/core/network/api_consumer.dart';
import 'package:flutter_application_1/core/network/api_endpoints.dart';
import 'package:flutter_application_1/features/product/data/product_model.dart';
import 'package:meta/meta.dart';

part 'popular_product_state.dart';

class PopularProductCubit extends Cubit<PopularProductState> {
  final ApiConsumer api;
  PopularProductCubit(this.api) : super(PopularProductInitial());

  Future<void> getallproduct() async {
    try {
      emit(PopularProductloading());
      final Response = await api.get(ApiEndpoints.productall);

      List<dynamic> data = Response['list'];
      List<productmodel> products = data
          .map((e) => productmodel.fromjson(e))
          .toList();

      // 🔥 نعمل فلترة Popular
      products.sort((a, b) => b.rating!.compareTo(a.rating!));

      List<productmodel> popularProducts = products.take(14).toList();
      emit(PopularProductsuccess(popularProducts));
    } catch (e) {
      emit(PopularProductfailer(errormessag: e.toString()));
    }
  }
}
