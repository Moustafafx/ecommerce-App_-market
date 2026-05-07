import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/core/network/api_consumer.dart';
import 'package:flutter_application_1/core/network/api_endpoints.dart';
import 'package:flutter_application_1/features/category/data/Category_model.dart';
import 'package:flutter_application_1/features/category/data/catrgoy_response_model.dart';
import 'package:meta/meta.dart';

part 'cubit_category_state.dart';

class CubitCategoryCubit extends Cubit<CubitCategoryState> {
   final ApiConsumer api; 
  CubitCategoryCubit(this.api) : super(CubitCategoryInitial());

  List<CategoryModel> categories = [];

  Future<void> getProducts() async {
    try {
      emit(categoryLoading());

      final response = await api.get(ApiEndpoints.categoriesall);

    
   final data = CategoryResponseModel.fromJson(response);
  categories = data.categories;
  
      emit(categorySuccess());
    } catch (e) {
      emit(categoryError(errormessag:e.toString()));
    }
  }








}




