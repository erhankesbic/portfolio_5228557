
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart'; // Import AppTheme

class ThemeViewModel extends ChangeNotifier {
  static const String _primaryColorKey = 'primary_color';
  static const Color _defaultColor = Colors.blue;

  late Color _primaryColor;

  ThemeViewModel() {
    _primaryColor = _defaultColor;
    _loadTheme();
  }

  Color get primaryColor => _primaryColor;

  // Updated to use the new dynamic theme methods
  ThemeData get lightTheme => AppTheme.getLightTheme(_primaryColor);
  ThemeData get darkTheme => AppTheme.getDarkTheme(_primaryColor);

  Future<void> setPrimaryColor(Color color) async {
    _primaryColor = color;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_primaryColorKey, color.toARGB32());
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final colorValue = prefs.getInt(_primaryColorKey);
    if (colorValue != null) {
      _primaryColor = Color(colorValue);
    }
    notifyListeners();
  }
}
