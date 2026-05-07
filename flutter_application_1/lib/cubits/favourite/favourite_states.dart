abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<dynamic> products; // ✅ أضفنا البيانات
  FavoriteLoaded(this.products);
}

class FavoriteUpdated extends FavoriteState {}

class FavoriteError extends FavoriteState {
  final String message;
  FavoriteError(this.message);
}