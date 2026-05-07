part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}   // قبل ما يكتب حاجة
final class SearchLoading extends SearchState {}   // جاري البحث
final class SearchEmpty extends SearchState {}     // مفيش نتايج
final class SearchSuccess extends SearchState {    // في نتايج
  final List results;
  SearchSuccess({required this.results});
}
final class SearchError extends SearchState {      // حصل error
  final String error;
  SearchError({required this.error});
}