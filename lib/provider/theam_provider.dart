import 'package:flutter/material.dart';

enum AppThemeMode {
  light,
  dark,
  sepia,
}

class ThemeProvider extends ChangeNotifier {
  AppThemeMode _theme = AppThemeMode.light;

  AppThemeMode get theme => _theme;

  void setTheme(AppThemeMode theme) {
    _theme = theme;
    notifyListeners();
  }
}