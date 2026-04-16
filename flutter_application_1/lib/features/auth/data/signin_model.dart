import 'package:flutter_application_1/core/network/api_endpoints.dart';
import 'package:flutter_application_1/features/auth/data/user_model.dart';

class SigninModel {
final String message;
  final String token;
  final UserModel user;

  SigninModel({
    required this.message,
    required this.token,
    required this.user,
  });

  factory SigninModel.fromJson(Map<String, dynamic> json) {
    return SigninModel(
      message: json[Apikey.errormessage],
      token: json[Apikey.token],
      user: UserModel.fromJson(json['user']),
      
    );
  }
}


