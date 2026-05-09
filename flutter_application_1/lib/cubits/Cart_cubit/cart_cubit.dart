import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/core/network/api_consumer.dart';
import 'package:flutter_application_1/cubits/Cart_cubit/cart_state.dart';
import 'package:flutter_application_1/features/cart/data/cart_model.dart';
import 'package:meta/meta.dart';


class CartCubit extends Cubit<CartState> {
  final ApiConsumer api;
  CartCubit(this.api) : super(CartInitial());

  final String baseUrl = 'YOUR_BASE_URL';
  final String token = 'USER_TOKEN'; // جيبه من SharedPreferences أو AuthCubit

  List<CartProduct> _products = [];

  // ✅ جيب الكارت
Future<void> getCart() async {
  emit(CartLoading());
  try {
    final response = await api.get('/user/getCart');

    final rawList = response['list'];

    if (rawList == null || (rawList as List).isEmpty) {
      _products = [];
      emit(CartLoaded(_products));
      return;
    }

    // ✅ مباشرة من list
    _products = (rawList as List)
        .map((e) => CartProduct.fromJson(e))
        .toList();

    emit(CartLoaded(_products));
  } catch (e) {
    print('CART ERROR: $e');
    emit(CartError('حصل خطأ في تحميل الكارت'));
  }
}

  // ✅ أضف للكارت
  Future<void> addToCart(int productId) async {
    try {
      await api.post(
        '/user/addCart',
        data: {'productId': '$productId'},
      );
      await getCart();
    } on DioException catch (e) {
      emit(CartError(e.response?.data['message'] ?? 'فشل الإضافة'));
    }
  }

  // ✅ احذف من الكارت
  Future<void> deleteFromCart(int productId) async {
    try {
      await api.delete(
        '/user/deleteCart',
        data: {'productId': '$productId'},
      );
      await getCart();
    } on DioException catch (e) {
      emit(CartError(e.response?.data['message'] ?? 'فشل الحذف'));
    }
  }

  double get totalPrice =>
      _products.fold(0, (sum, p) => sum + p.price * p.quantity);
}
