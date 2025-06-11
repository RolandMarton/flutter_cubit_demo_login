import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:login_cubit_test/services/analytics_service.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final AnalyticsService _analytics;

  ThemeCubit(this._analytics) : super(ThemeMode.light);

  void toggleTheme() {
    final newTheme = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    _analytics.logEvent('theme_toggle', params: {'theme': newTheme.toString()});
    emit(newTheme);
  }
}