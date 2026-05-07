part of 'popular_product_cubit.dart';

@immutable
sealed class PopularProductState {}

final class PopularProductInitial extends PopularProductState {}
final class PopularProductloading extends PopularProductState {}
final class PopularProductsuccess extends PopularProductState {
  final List<productmodel> products;

  PopularProductsuccess(this.products);

}
final class PopularProductfailer extends PopularProductState {
final String errormessag;

  PopularProductfailer({required this.errormessag});

}

