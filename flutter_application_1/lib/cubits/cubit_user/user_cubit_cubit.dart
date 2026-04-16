import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/core/cache/shared_preferences_cache.dart';
import 'package:flutter_application_1/core/network/api_endpoints.dart';
import 'package:flutter_application_1/core/network/api_consumer.dart';
import 'package:flutter_application_1/core/network/api_exceptions.dart';
import 'package:flutter_application_1/features/auth/data/signin_model.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:meta/meta.dart';

part 'user_cubit_state.dart';

class UserCubitCubit extends Cubit<UserCubitState> {
  UserCubitCubit(this._apiConsumer) : super(UserCubitInitial());
final ApiConsumer _apiConsumer;
SigninModel?user;
Future<dynamic>signin(String email,String password)async{


 try {
  emit(userloadingdata());
  final request =await _apiConsumer.post(
    ApiEndpoints.signin,data:{
    Apikey.email:email,
    Apikey.password:password,

  } 
  );

   user=SigninModel.fromJson(request);
  final decoded= JwtDecoder.decode(user!.token);
  print(decoded["id"]);
   emit(usersuccesssignin());
   SharedPreferencesCache.setdata(key: Apikey.token, value:user!.token );
      SharedPreferencesCache.setdata(key: Apikey.id, value: decoded[Apikey.id] );
} on ApiExceptions catch (e) {
  emit(userfailersignin(errormessage:e.apiErrorModel.errormessage ));
}
  
}



}
