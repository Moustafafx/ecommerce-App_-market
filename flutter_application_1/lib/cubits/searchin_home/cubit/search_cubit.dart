import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/core/network/api_consumer.dart';
import 'package:flutter_application_1/core/network/api_endpoints.dart';
import 'package:flutter_application_1/core/network/api_exceptions.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final ApiConsumer api;
  SearchCubit(this.api) : super(SearchInitial());

  Timer? _debounce; // ✅ بيأخر الـ request

  void onSearchChanged(String query) {
    // لو الـ query فاضي، رجع للحالة الأولى
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    // ✅ Debounce: استنى 500ms بعد ما المستخدم يوقف عن الكتابة
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _search(query);
    });
  }

 Future<void> _search(String query) async {
  try {
    emit(SearchLoading());

    // ✅ POST مش GET
    final response = await api.post(
      ApiEndpoints.searchinhome,
      data: {
        "search": query,
        "skip": 0,
        "limit": 10,
      },
    );

    print("Search Response: $response");

    // ✅ تأكد إن list مش null
    final rawList = response['list'];
    if (rawList == null) {
      emit(SearchEmpty());
      return;
    }

    final results = rawList as List;

    if (results.isEmpty) {
      emit(SearchEmpty());
    } else {
      emit(SearchSuccess(results: results));
    }

  } catch (e) {
    print("Search Error: $e");
       // ✅ لو السيرفر رجع 404 أو "not found" = مفيش نتايج مش error
    if (e is ApiExceptions) {
      emit(SearchEmpty()); // ✅ ورّي "No results found" بدل الـ error
    } else {
      emit(SearchError(error: "Something went wrong"));
    }
  }
}
}