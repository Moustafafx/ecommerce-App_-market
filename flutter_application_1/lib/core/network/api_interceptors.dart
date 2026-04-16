import 'package:dio/dio.dart';
import 'package:flutter_application_1/core/cache/shared_preferences_cache.dart';
import 'package:flutter_application_1/core/network/api_endpoints.dart';

class ApiInterceptors extends Interceptor {
 @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
options.headers["Content-Type"]="application/json";

// ✅ الخطوة السحرية: جلب التوكن من الكاش وحقنه في الـ Headers
    // ملاحظة: استبدل CacheHelper بالكلاس اللي إنت بتستخدمه للتخزين
    String? token = SharedPreferencesCache.getdata(key: Apikey.token); 

    if (token != null) {
      options.headers["Authorization"] = "Bearer $token";
    }


    super.onRequest(options, handler);
  }

   
}