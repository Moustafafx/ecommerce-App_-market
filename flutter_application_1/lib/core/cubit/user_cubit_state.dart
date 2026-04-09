part of 'user_cubit_cubit.dart';

@immutable
sealed class UserCubitState {}

final class UserCubitInitial extends UserCubitState {}
final class userloadingdata extends UserCubitState {}
final class usersuccesssignin extends UserCubitState {}
final class userfailersignin extends UserCubitState {

  final String errormessage;

  userfailersignin({required this.errormessage});
}

