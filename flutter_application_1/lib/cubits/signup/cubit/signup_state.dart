part of 'signup_cubit.dart';

@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {}
final class Signuploading extends SignupState {}
final class Signupsuccess extends SignupState {
  final String message;

  Signupsuccess({required this.message});
}
final class Signuperror extends SignupState {
  final String error;

  Signuperror({required this.error});

 
}