part of 'cubit_category_cubit.dart';

@immutable
sealed class CubitCategoryState {}

final class CubitCategoryInitial extends CubitCategoryState {}
final class categoryLoading extends CubitCategoryState {}
final class categorySuccess extends CubitCategoryState {}
final class categoryError extends CubitCategoryState {
  final String errormessag;

  categoryError({required this.errormessag});
}

