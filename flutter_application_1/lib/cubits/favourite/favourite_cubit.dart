import 'package:flutter_application_1/core/network/api_consumer.dart';
import 'package:flutter_application_1/core/network/api_endpoints.dart';
import 'package:flutter_application_1/cubits/favourite/favourite_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit(this.api) : super(FavoriteInitial());
  final ApiConsumer api;
  List<int> favoriteIds = [];
  List<Map<String, dynamic>> favoriteProducts = [];

  Future<void> getFavorites() async {
    emit(FavoriteLoading());
    try {
      final response = await api.get(ApiEndpoints.getfavourite);
      final List<dynamic> outerList = response['list'];

      // ✅ جيب كل المنتجات من كل الـ items
      final List<Map<String, dynamic>> allProducts = [];
      for (var item in outerList) {
        final List<dynamic> products = item['list'] ?? [];
        for (var p in products) {
          allProducts.add(Map<String, dynamic>.from(p));
        }
      }

      // ✅ ريسيت كامل من السيرفر
      favoriteIds = allProducts.map<int>((p) => p['id'] as int).toList();
      favoriteProducts = allProducts;

      print("FAVORITE IDS FROM SERVER: $favoriteIds");
      emit(FavoriteLoaded(favoriteProducts));
    } catch (e) {
      print("ERROR: $e");
      emit(FavoriteError(e.toString()));
    }
  }

  Future<void> toggleFavorite(
    int productId, {
    Map<String, dynamic>? productData, // ✅ بنبعت بيانات المنتج معاه
  }) async {
    try {
      if (favoriteIds.contains(productId)) {
        // ✅ شيل فوراً
        favoriteIds.remove(productId);
        favoriteProducts.removeWhere((e) => e['id'] == productId);
        emit(FavoriteUpdated());
        await api.delete(ApiEndpoints.deletefavourite, data: {"productId": productId});
      } else {
        // ✅ أضف فوراً محلياً
        favoriteIds.add(productId);
        if (productData != null) {
          favoriteProducts.add(productData);
        }
        emit(FavoriteUpdated());
        await api.post(ApiEndpoints.addfavourite, data: {"productId": productId});
      }
    } catch (e) {
      print("TOGGLE ERROR: $e");
      // ✅ لو فشل، رجّع الحالة
      if (favoriteIds.contains(productId)) {
        favoriteIds.remove(productId);
      } else {
        favoriteIds.add(productId);
      }
      emit(FavoriteError(e.toString()));
    }
  }
}