import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/cache/shared_preferences_cache.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  static const String themeKey = "theme";

  // 🔥 تحميل الثيم عند فتح التطبيق
  void loadTheme() {
    final isDark = SharedPreferencesCache.getdata(key: themeKey) ?? false;

    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }


  void toggleTheme(bool isDark) {
    SharedPreferencesCache.setdata(
      key: themeKey,
      value: isDark,
    );

    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }
}
