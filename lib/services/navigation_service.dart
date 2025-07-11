import 'package:flutter/material.dart';
import '../pages/profile_form_page.dart';
import '../pages/slider_page.dart';
import '../pages/settings_page.dart';
import '../pages/summary_page.dart';
import '../models/user_data.dart';

/// Service für die Navigation zwischen Seiten
///
/// Kapselt die gesamte Navigation-Logik und macht sie testbar.
/// Folgt dem Single Responsibility Principle.
class NavigationService {
  /// Navigiert zur Profilseite und gibt die Ergebnisse zurück
  ///
  /// [context] - Build Context für Navigation
  /// [currentData] - Aktuelle Profildaten
  ///
  /// Returns: Map mit den neuen Profildaten oder null
  static Future<Map<String, String>?> navigateToProfile(
    BuildContext context, {
    required String name,
    required String email,
    required String about,
  }) async {
    final result = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder:
            (_) => ProfileFormPage(
              initialName: name,
              initialEmail: email,
              initialAbout: about,
            ),
      ),
    );

    return result;
  }

  /// Navigiert zur Slider-Seite
  ///
  /// [context] - Build Context für Navigation
  /// [currentValue] - Aktueller Slider-Wert
  ///
  /// Returns: Neuer Slider-Wert oder null
  static Future<double?> navigateToSlider(
    BuildContext context, {
    required double currentValue,
  }) async {
    final result = await Navigator.push<double>(
      context,
      MaterialPageRoute(builder: (_) => SliderPage(initialValue: currentValue)),
    );

    return result;
  }

  /// Navigiert zu den Einstellungen
  ///
  /// [context] - Build Context für Navigation
  /// [currentSettings] - Aktuelle Einstellungen
  ///
  /// Returns: Map mit neuen Einstellungen oder null
  static Future<Map<String, dynamic>?> navigateToSettings(
    BuildContext context, {
    required bool newsletter,
    required bool darkMode,
    required bool notifications,
    required bool offlineMode,
  }) async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder:
            (_) => SettingsPage(
              initialNewsletter: newsletter,
              initialDarkMode: darkMode,
              initialNotifications: notifications,
              initialOfflineMode: offlineMode,
            ),
      ),
    );

    return result;
  }

  /// Navigiert zur Zusammenfassungsseite
  ///
  /// [context] - Build Context für Navigation
  /// [userData] - Alle Benutzerdaten
  static Future<void> navigateToSummary(
    BuildContext context, {
    required UserData userData,
  }) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => SummaryPage(data: userData)),
    );
  }
}
