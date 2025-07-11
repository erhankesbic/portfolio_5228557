import '../pages/user_data.dart';

/// Repository für Benutzerdaten-Management
/// 
/// Kapselt die gesamte Logik für Benutzerdaten-Updates.
/// Folgt dem Repository Pattern und Single Responsibility Principle.
class UserRepository {
  UserData _userData = const UserData();

  /// Gibt die aktuellen Benutzerdaten zurück
  UserData get currentUser => _userData;

  /// Prüft ob der Benutzer vollständige Profildaten hat
  bool get hasCompleteProfile => _userData.hasCompleteProfile;

  /// Aktualisiert die Profildaten
  /// 
  /// [name] - Neuer Name
  /// [email] - Neue E-Mail
  /// [about] - Neue Beschreibung
  void updateProfile({
    required String name,
    required String email,
    required String about,
  }) {
    _userData = _userData.copyWith(
      name: name,
      email: email,
      about: about,
    );
  }

  /// Aktualisiert den Slider-Wert
  /// 
  /// [value] - Neuer Slider-Wert
  void updateSliderValue(double value) {
    _userData = _userData.copyWith(sliderValue: value);
  }

  /// Aktualisiert alle Einstellungen
  /// 
  /// [newsletter] - Newsletter-Status
  /// [darkMode] - Dark Mode Status
  /// [notifications] - Benachrichtigungs-Status
  /// [offlineMode] - Offline-Modus Status
  void updateSettings({
    required bool newsletter,
    required bool darkMode,
    required bool notifications,
    required bool offlineMode,
  }) {
    _userData = _userData.copyWith(
      newsletter: newsletter,
      darkMode: darkMode,
      notifications: notifications,
      offlineMode: offlineMode,
    );
  }

  /// Setzt alle Daten zurück
  void reset() {
    _userData = const UserData();
  }

  /// Erstellt eine Kopie der aktuellen Daten
  UserData createSnapshot() {
    return _userData.copyWith();
  }
}
