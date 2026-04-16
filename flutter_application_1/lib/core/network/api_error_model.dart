import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/core/network/api_endpoints.dart';

class ApiErrorModel {

final String errormessage;

  ApiErrorModel({ required this.errormessage});


 factory ApiErrorModel.fromjson(Map<String,dynamic>json){
  return ApiErrorModel(errormessage: json[Apikey.errormessage]);
}
}

