import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/core/network/api_consumer.dart';
import 'package:flutter_application_1/features/category/data/Category_model.dart';
import 'package:flutter_application_1/features/category/data/product_model.dart';
import 'package:meta/meta.dart';

part 'related_Category_cubit_state.dart';

class RelatedCategoryCubitCubit extends Cubit<RelatedProductsCubitState> {
  final ApiConsumer api;

  RelatedCategoryCubitCubit(this.api) : super(RelatedCategoryCubitInitial());

  List<categorydetailsModel> products = [];

  Future<void> getRelatedcategoryCubit(String url) async {
    try {
      emit(RelatedCategoryCubitLoading());

      final response = await api.get(url);

      List data = response['products'];

      products = data.map((e) => categorydetailsModel.fromJson(e)).toList();

      emit(RelatedCategoryCubitSuccess());
    } catch (e) {
      emit(RelatedCategoryCubitErrorl(errormessag: e.toString()));
    }
  }
}


//class RelatedCategoryCubitCubit extends Cubit<RelatedProductsCubitState> {
//   final ApiConsumer api;
//   RelatedCategoryCubitCubit(this.api) : super(RelatedCategoryCubitInitial());

// Future<void> getRelatedcategoryCubit(String url) async {
//   emit((RelatedCategoryCubitLoading()));

//   try {
//     final response = await api.get(url);

//     // 👇 هنا الداتا اللي جوا ال URL
//     List data = response.data['products'];

//     List<CategoryModel> RelatedCategory =
//         data.map((e) => CategoryModel.fromJson(e)).toList();

//     emit(RelatedCategoryCubitSuccess());
//   } catch (e) {
//     emit(RelatedCategoryCubitErrorl( errormessag:e.toString()));
//   }
// }


// }