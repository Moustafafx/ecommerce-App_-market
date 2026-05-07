import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/core/cache/shared_preferences_cache.dart';
import 'package:flutter_application_1/core/network/api_consumer.dart';
import 'package:flutter_application_1/core/network/api_endpoints.dart';
import 'package:flutter_application_1/core/network/api_exceptions.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
 final ApiConsumer  api ; 
  SignupCubit(this.api) : super(SignupInitial());

Future<void> signUp({

  required String name,
  required String phone,
  required String email,
  required String password,
  required String confirmPassword,


}) async {
  try {
    emit(Signuploading());

    final response = await api.post(
      ApiEndpoints.signUp,
      data: {
        Apikey.name: name,
        Apikey.phone: phone,
        Apikey.email: email,
        Apikey.password: password,
        Apikey.confirmpassword: confirmPassword,
      },
    );

    // ✅ بدل ما تعمل throw، عرض الـ error مباشرة
    if (response == null) {
      emit(Signuperror(error: "حدث خطأ، حاول مرة أخرى"));
      return;
    }

  final message = response["message"] ?? "No message";
    await SharedPreferencesCache.setdata(key: "name", value: name);
    await SharedPreferencesCache.setdata(key: "email", value: email);
    emit(Signupsuccess(message: message));

  } on ApiExceptions catch (e) {
    emit(Signuperror(error: e.apiErrorModel.errormessage));
  } catch (e) {
    // ✅ أضف catch عام يمسك أي خطأ تاني
    emit(Signuperror(error: e.toString()));
  }
}
}



