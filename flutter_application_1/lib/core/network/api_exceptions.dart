import 'package:dio/dio.dart';
import 'package:flutter_application_1/core/network/api_error_model.dart';

class ApiExceptions implements Exception{
 final ApiErrorModel apiErrorModel;

  ApiExceptions({required this.apiErrorModel});

 



}


void handel_dio_exeption(DioException e) {
    switch(e.type){
     
      case DioExceptionType.connectionTimeout:
      
        throw ApiExceptions(apiErrorModel:ApiErrorModel.fromjson(e.response!.data));
      case DioExceptionType.sendTimeout:
        throw ApiExceptions(apiErrorModel:ApiErrorModel.fromjson(e.response!.data));
      case DioExceptionType.receiveTimeout:
      throw ApiExceptions(apiErrorModel:ApiErrorModel.fromjson(e.response!.data));
      case DioExceptionType.badCertificate:
      throw ApiExceptions(apiErrorModel:ApiErrorModel.fromjson(e.response!.data));
    
      case DioExceptionType.cancel:
      throw ApiExceptions(apiErrorModel:ApiErrorModel.fromjson(e.response!.data));
      case DioExceptionType.connectionError:
      throw ApiExceptions(apiErrorModel:ApiErrorModel.fromjson(e.response!.data));
      case DioExceptionType.unknown:
      throw ApiExceptions(apiErrorModel:ApiErrorModel.fromjson(e.response!.data));
    
    
           case DioExceptionType.badResponse:
     final statuscode=e.response?.statusCode;
     switch(statuscode){
     case 400:
        throw ApiExceptions(apiErrorModel:ApiErrorModel.fromjson(e.response!.data));
    case 401:
       throw ApiExceptions(apiErrorModel:ApiErrorModel.fromjson(e.response!.data));
     case 403:
        throw ApiExceptions(apiErrorModel:ApiErrorModel.fromjson(e.response!.data));
      case 404:
         throw ApiExceptions(apiErrorModel:ApiErrorModel.fromjson(e.response!.data));
       case 409:
          throw ApiExceptions(apiErrorModel:ApiErrorModel.fromjson(e.response!.data));
        case 422:
           throw ApiExceptions(apiErrorModel:ApiErrorModel.fromjson(e.response!.data));
         case 504:
            throw ApiExceptions(apiErrorModel:ApiErrorModel.fromjson(e.response!.data));
     }
    }
  }