import 'package:flutter/material.dart';

class ThemeService {
  ThemeMode currentTheme = ThemeMode.light;

  void toggleTheme() {
    currentTheme = currentTheme == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    print("ThemeController: Theme switched to $currentTheme");
  }
}