import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // Constant design tokens
  static const Color errorColor = Colors.red;
  static const Color warningColor = Colors.orange;
  static const Color successColor = Colors.green;
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);
  static const Color backgroundLight = Color(0xFFFAFAFA);
  static const Color backgroundDark = Color(0xFF303030);
  
  static const Color primaryLight = Color(0xFFE3F2FD);
  static const Color primaryDark = Color(0xFF1976D2);


  // Spacing and sizes
  static const double spacingXSmall = 4.0;
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;
  static const double spacingXLarge = 32.0;
  static const double spacingXXLarge = 48.0;

  // Radius
  
  static const double radiusSmall = 4.0;
  static const double radiusMedium = 8.0;
  static const double radiusLarge = 12.0;
  static const double radiusXLarge = 16.0;

  // Avatar Sizes
  static const double avatarMedium = 40.0;

  // Button Sizes
  static const double buttonMediumWidth = 160.0;
  static const double buttonHeight = 48.0;

  // Icon Sizes
  static const double iconSmall = 16.0;
  static const double iconLarge = 32.0;

  // Text Styles
  static const TextStyle headlineLarge = TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold);
  static const TextStyle headlineMedium = TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold);
  static const TextStyle headlineSmall = TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600);
  static const TextStyle titleLarge = TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600);
  static const TextStyle titleMedium = TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500);
  static const TextStyle bodyLarge = TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal);
  static const TextStyle bodyMedium = TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal);
  static const TextStyle bodySmall = TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal);
  static const TextStyle labelLarge = TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500);

  /// Creates a dynamic light theme based on a primary color.
  static ThemeData getLightTheme(Color primaryColor) {
    return ThemeData(
      useMaterial3: false,
      primarySwatch: _createMaterialColor(primaryColor),
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.light,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      cardColor: ColorScheme.fromSeed(seedColor: primaryColor, brightness: Brightness.light).surface,
      dialogTheme: DialogThemeData(
        backgroundColor: ColorScheme.fromSeed(seedColor: primaryColor, brightness: Brightness.light).surface,
      ),
      // ... other theme properties
    );
  }

  /// Creates a dynamic dark theme based on a primary color.
  static ThemeData getDarkTheme(Color primaryColor) {
    return ThemeData(
      useMaterial3: false,
      primarySwatch: _createMaterialColor(primaryColor),
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.dark,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      textTheme: TextTheme(
        headlineLarge: headlineLarge.copyWith(color: Colors.white),
        headlineMedium: headlineMedium.copyWith(color: Colors.white),
        headlineSmall: headlineSmall.copyWith(color: Colors.white),
        titleLarge: titleLarge.copyWith(color: Colors.white),
        titleMedium: titleMedium.copyWith(color: Colors.white),
        bodyLarge: bodyLarge.copyWith(color: Colors.white),
        bodyMedium: bodyMedium.copyWith(color: Colors.white),
        bodySmall: bodySmall.copyWith(color: Colors.white70),
        labelLarge: labelLarge.copyWith(color: Colors.white),
      ),
      cardColor: ColorScheme.fromSeed(seedColor: primaryColor, brightness: Brightness.dark).surface,
      dialogTheme: DialogThemeData(
        backgroundColor: ColorScheme.fromSeed(seedColor: primaryColor, brightness: Brightness.dark).surface,
      ),
      scaffoldBackgroundColor: ColorScheme.fromSeed(seedColor: primaryColor, brightness: Brightness.dark).background,
      // ... other theme properties
    );
  }

  // Helper to create a MaterialColor from a single Color.
  static MaterialColor _createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red;
    final int g = color.green;
    final int b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.toARGB32(), swatch);
  }
}
