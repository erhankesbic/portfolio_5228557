/// Modell-Klasse für Benutzerdaten
///
/// Enthält alle relevanten Informationen eines Benutzers:
/// - Persönliche Daten (Name, E-Mail, Beschreibung)
/// - App-Einstellungen (Newsletter, Dark Mode, etc.)
/// - UI-Präferenzen (Slider-Wert)
class UserData {
  /// Vollständiger Name des Benutzers
  final String name;

  /// E-Mail-Adresse des Benutzers
  final String email;

  /// Kurze Beschreibung über den Benutzer
  final String about;

  /// Aktueller Slider-Wert (0-100)
  final double sliderValue;

  /// Newsletter-Abonnement Status
  final bool newsletter;

  /// Dark Mode Einstellung
  final bool darkMode;

  /// Benachrichtigungen aktiviert
  final bool notifications;

  /// Offline-Modus aktiviert
  final bool offlineMode;

  /// Erstellt eine neue UserData-Instanz
  const UserData({
    this.name = '',
    this.email = '',
    this.about = '',
    this.sliderValue = 50.0,
    this.newsletter = false,
    this.darkMode = false,
    this.notifications = false,
    this.offlineMode = false,
  });

  /// Erstellt eine Kopie mit geänderten Werten
  UserData copyWith({
    String? name,
    String? email,
    String? about,
    double? sliderValue,
    bool? newsletter,
    bool? darkMode,
    bool? notifications,
    bool? offlineMode,
  }) {
    return UserData(
      name: name ?? this.name,
      email: email ?? this.email,
      about: about ?? this.about,
      sliderValue: sliderValue ?? this.sliderValue,
      newsletter: newsletter ?? this.newsletter,
      darkMode: darkMode ?? this.darkMode,
      notifications: notifications ?? this.notifications,
      offlineMode: offlineMode ?? this.offlineMode,
    );
  }

  /// Prüft ob alle persönlichen Daten ausgefüllt sind
  bool get hasCompleteProfile => name.isNotEmpty && email.isNotEmpty;

  /// Gibt die Anzahl aktivierter Einstellungen zurück
  int get activeSettingsCount {
    int count = 0;
    if (newsletter) count++;
    if (darkMode) count++;
    if (notifications) count++;
    if (offlineMode) count++;
    return count;
  }

  @override
  String toString() {
    return 'UserData(name: $name, email: $email, settings: $activeSettingsCount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserData &&
        other.name == name &&
        other.email == email &&
        other.about == about &&
        other.sliderValue == sliderValue &&
        other.newsletter == newsletter &&
        other.darkMode == darkMode &&
        other.notifications == notifications &&
        other.offlineMode == offlineMode;
  }

  @override
  int get hashCode {
    return Object.hash(
      name,
      email,
      about,
      sliderValue,
      newsletter,
      darkMode,
      notifications,
      offlineMode,
    );
  }
}
