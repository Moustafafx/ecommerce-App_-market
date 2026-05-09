import 'package:flutter_application_1/features/cart/data/cart_model.dart';

abstract class CartState {}

class CartInitial extends CartState {}
class CartLoading extends CartState {}
class CartLoaded extends CartState {
  final List<CartProduct> products;
  CartLoaded(this.products);
}
class CartError extends CartState {
  final String message;
  CartError(this.message);
}
class CartActionLoading extends CartState {} // لما بيضيف أو بيحذف