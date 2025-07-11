/// Zentrale Konstanten für die gesamte Anwendung
///
/// Diese Klasse enthält alle Design-Konstanten, Strings und andere
/// wiederverwendbare Werte für eine konsistente UI.
class AppConstants {
  // Private Konstruktor verhindert Instanziierung
  AppConstants._();

  // === DESIGN KONSTANTEN ===

  /// Avatar-Größen
  static const double avatarRadius = 40.0;
  static const double avatarIconSize = 48.0; // avatarRadius + 8

  /// Padding und Abstände
  static const double mainPadding = 32.0;
  static const double smallPadding = 8.0;
  static const double mediumPadding = 16.0;
  static const double largePadding = 24.0;
  static const double extraLargePadding = 36.0;

  /// Button-Dimensionen
  static const double buttonSpacing = 16.0;
  static const double buttonHeight = 48.0;
  static const double buttonWidth = 160.0;

  /// Schriftgrößen
  static const double headerFontSize = 22.0;
  static const double subHeaderFontSize = 16.0;
  static const double bodyFontSize = 15.0;
  static const double smallFontSize = 12.0;

  // === UI STRINGS ===

  /// App-weite Texte
  static const String appTitle = 'Mein Portfolio';
  static const String welcomeDefault = 'Willkommen im Portfolio';
  static const String welcomePersonalized = 'Willkommen';

  /// Navigation Labels
  static const String profilePageLabel = 'Profilseite';
  static const String sliderPageLabel = 'Slider-Seite';
  static const String settingsPageLabel = 'Einstellungen';
  static const String summaryPageLabel = 'Zusammenfassung';

  /// Form Labels und Hints
  static const String nameLabel = 'Name';
  static const String emailLabel = 'E-Mail';
  static const String aboutLabel = 'Über mich';
  static const String saveLabel = 'Speichern';
  static const String cancelLabel = 'Abbrechen';

  /// Settings Labels
  static const String newsletterLabel = 'Newsletter abonnieren';
  static const String darkModeLabel = 'Dark Mode';
  static const String notificationsLabel = 'Benachrichtigungen';
  static const String offlineModeLabel = 'Offline-Modus';

  /// Error Messages
  static const String nameRequiredError = 'Name ist erforderlich';
  static const String nameMinLengthError =
      'Name muss mindestens 2 Zeichen haben';
  static const String emailRequiredError = 'E-Mail ist erforderlich';
  static const String emailInvalidError = 'Ungültige E-Mail-Adresse';
  static const String aboutMaxLengthError =
      'Beschreibung darf maximal 200 Zeichen haben';

  // === VALIDIERUNG KONSTANTEN ===

  /// Validierung Limits
  static const int nameMinLength = 2;
  static const int nameMaxLength = 50;
  static const int aboutMaxLength = 200;

  /// Slider Werte
  static const double sliderMin = 0.0;
  static const double sliderMax = 100.0;
  static const double sliderDefault = 50.0;
}
