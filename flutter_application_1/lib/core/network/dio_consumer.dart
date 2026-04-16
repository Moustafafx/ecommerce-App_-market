import 'package:dio/dio.dart';
import 'package:flutter_application_1/core/network/api_endpoints.dart';
import 'package:flutter_application_1/core/network/api_consumer.dart';
import 'package:flutter_application_1/core/network/api_exceptions.dart';
import 'package:flutter_application_1/core/network/api_interceptors.dart';

class DioConsumer extends ApiConsumer{
 final Dio dio;

  DioConsumer(this.dio, ){
    dio.options.baseUrl=ApiEndpoints.baseUrl;
  dio.interceptors.add(ApiInterceptors());
   dio.interceptors.add(LogInterceptor(
    request: true,
    requestBody: true,
    requestHeader: true,
    responseBody: true,
    error: true
   ));
  }
  @override
  Future<dynamic> delete(String path, {dynamic? data, Map<String, dynamic>? queryparameter, bool isformdata=false,})async {
try {
  final Request =await dio.delete(path,data:isformdata?FormData.fromMap(data) :data,queryParameters: queryparameter );
   return Request.data;
} on DioException catch (e) {
 handel_dio_exeption(e);
}
    
  }

  

  @override
  Future<dynamic> get(String path, {dynamic? data, Map<String, dynamic>? queryparameter, bool isformdata=false,})async {
try {
  final Response =await dio.get(path,data:isformdata? FormData.fromMap(data) : data,queryParameters: queryparameter );
   return Response.data;
} on DioException catch (e) {
 handel_dio_exeption(e);
}
  }

  @override
  Future<dynamic> patch(String path, {dynamic? data, Map<String, dynamic>? queryparameter, bool isformdata=false,})async {
try {
  final request =await dio.patch(path,data:isformdata?FormData.fromMap(data): data,queryParameters:queryparameter );
   return request.data;
} on DioException catch (e) {
 handel_dio_exeption(e);
}
  }

  @override
  Future<dynamic> post(String path, {dynamic? data, Map<String, dynamic>? queryparameter, bool isformdata=false })async {
 try {
  final request =await dio.post(path,data:isformdata?FormData.fromMap(data): data,queryParameters: queryparameter);
   return request.data;
} on DioException catch (e) {
 handel_dio_exeption(e);
}
  }

 


  
}