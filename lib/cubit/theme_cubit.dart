import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:login_cubit_test/services/theme_service.dart';
import 'package:login_cubit_test/services/analytics_service.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final ThemeService _themeService;
  final AnalyticsService _analytics;

  ThemeCubit(this._themeService, this._analytics) : super(_themeService.currentTheme);

  void toggleTheme() {
    _themeService.toggleTheme();
    _analytics.logEvent('theme_toggle', params: {'theme': _themeService.currentTheme.toString()});
    emit(_themeService.currentTheme);
  }
}
