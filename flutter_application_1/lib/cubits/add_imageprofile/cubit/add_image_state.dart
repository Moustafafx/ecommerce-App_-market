part of 'add_image_cubit.dart';

@immutable
sealed class AddImageState {}

final class AddImageInitial extends AddImageState {}

// ✅ تغيير الاسم عشان يكون أوضح - الصورة اتاختارت محلياً
final class AddImageUploadSelected extends AddImageState {}

final class AddImageLoading extends AddImageState {}

final class AddImageSuccess extends AddImageState {}

final class AddImageError extends AddImageState {
  final String error;
  AddImageError({required this.error});
}