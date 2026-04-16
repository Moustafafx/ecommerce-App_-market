part of 'related_category_cubit_cubit.dart';

@immutable
sealed class RelatedProductsCubitState {}

final class RelatedCategoryCubitInitial extends RelatedProductsCubitState {}
final class RelatedCategoryCubitLoading extends RelatedProductsCubitState {}
final class RelatedCategoryCubitSuccess extends RelatedProductsCubitState {}
final class RelatedCategoryCubitErrorl extends RelatedProductsCubitState {

  final String errormessag;

  RelatedCategoryCubitErrorl({required this.errormessag});

 

  
}




// abstract class ProductsState {}

// class ProductsInitial extends ProductsState {}

// class ProductsLoading extends ProductsState {}

// class ProductsSuccess extends ProductsState {
//   final List<ProductModel> products;

//   ProductsSuccess(this.products);
// }

// class ProductsError extends ProductsState {
//   final String message;

//   ProductsError(this.message);
// }