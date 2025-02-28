import 'package:flutter/material.dart';
import 'package:tunes_reloaded/theme/app_theme.dart';

class ThemeProvider extends ChangeNotifier {
  // Initially light mode
  ThemeData _themeData = AppTheme.lightTheme;

  // Get current theme
  ThemeData get themeData => _themeData;

  // Check if dark mode is enabled
  bool get isDarkMode => _themeData == AppTheme.darkTheme;

  // Set theme with UI update
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners(); // Update UI
  }

  // Toggle theme between light and dark
  void toggleTheme() {
    themeData = isDarkMode ? AppTheme.lightTheme : AppTheme.darkTheme;
  }
}
