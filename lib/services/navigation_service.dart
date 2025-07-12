import 'package:flutter/material.dart';
import '../pages/about_page.dart';
import '../pages/contact_page.dart';
import '../pages/profile_form_page.dart';
import '../pages/settings_page.dart';
import '../pages/summary_page.dart';
import '../pages/work_page.dart';

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

  /// Navigiert zur Slider-Seite (jetzt in SettingsPage integriert)
  ///
  /// [context] - Build Context für Navigation
  static Future<void> navigateToSlider(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SettingsPage()),
    );
  }

  /// Navigiert zu den Einstellungen
  ///
  /// [context] - Build Context für Navigation
  static Future<void> navigateToSettings(
    BuildContext context,
  ) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SettingsPage()),
    );
  }

  /// Navigiert zur Zusammenfassungsseite
  ///
  /// [context] - Build Context für Navigation
  static Future<void> navigateToSummary(
    BuildContext context,
  ) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SummaryPage()),
    );
  }

  /// Navigiert zur Work-Portfolio-Seite
  ///
  /// [context] - Build Context für Navigation
  static Future<void> navigateToWork(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const WorkPage()),
    );
  }

  /// Navigiert zur About-Seite
  ///
  /// [context] - Build Context für Navigation
  static Future<void> navigateToAbout(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AboutPage()),
    );
  }

  /// Navigiert zur Kontakt-Seite
  ///
  /// [context] - Build Context für Navigation
  static Future<void> navigateToContact(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ContactPage()),
    );
  }
}

