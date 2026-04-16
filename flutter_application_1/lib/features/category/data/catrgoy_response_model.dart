import 'package:flutter_application_1/features/category/data/Category_model.dart';

class CategoryResponseModel {
  final List<CategoryModel> categories;

  CategoryResponseModel({required this.categories});

  factory CategoryResponseModel.fromJson(Map<String, dynamic> json) {
    return CategoryResponseModel(
      categories: List.from(json["list"])
          .map((e) => CategoryModel.fromJson(e))
          .toList(),
    );
  }
}