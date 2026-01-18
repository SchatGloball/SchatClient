import 'package:flutter/material.dart';
import 'package:schat2/eventStore.dart';
import 'package:schat2/theme/darkTheme.dart';
import 'package:schat2/theme/lightTheme.dart';

class ThemeProvider with ChangeNotifier {
  Color _accentColor = config.accentColor;
  
  Color get accentColor => _accentColor;
  
  void updateAccentColor(Color newColor) {
    _accentColor = newColor;
    notifyListeners();
  }
  
  ThemeData get themeData {
    if (config.isDarkTheme) {
      return darkTheme.copyWith(
        appBarTheme: AppBarThemeData(backgroundColor: _accentColor),
      );
    } else {
      return lightTheme.copyWith(
        appBarTheme: AppBarThemeData(backgroundColor: _accentColor),
      );
    }
  }
}