import '../constants/app_constants.dart';

/// Service für Eingabe-Validierung
///
/// Kapselt alle Validierungslogik und macht sie testbar.
/// Folgt dem Single Responsibility Principle.
class ValidationService {
  // Singleton Pattern
  static final ValidationService _instance = ValidationService._internal();
  factory ValidationService() => _instance;
  ValidationService._internal();

  // Email RegEx Pattern
  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  /// Validiert einen Namen
  ///
  /// [name] - Der zu validierende Name
  ///
  /// Returns: Fehlermeldung oder null wenn gültig
  static String? validateName(String? name) {
    if (name == null || name.trim().isEmpty) {
      return AppConstants.nameRequiredError;
    }

    final trimmedName = name.trim();

    if (trimmedName.length < AppConstants.nameMinLength) {
      return AppConstants.nameMinLengthError;
    }

    if (trimmedName.length > AppConstants.nameMaxLength) {
      return 'Name darf maximal ${AppConstants.nameMaxLength} Zeichen lang sein';
    }

    return null;
  }

  /// Validiert eine E-Mail-Adresse
  ///
  /// [email] - Die zu validierende E-Mail
  ///
  /// Returns: Fehlermeldung oder null wenn gültig
  static String? validateEmail(String? email) {
    if (email == null || email.trim().isEmpty) {
      return AppConstants.emailRequiredError;
    }

    final trimmedEmail = email.trim().toLowerCase();

    if (!_emailRegex.hasMatch(trimmedEmail)) {
      return AppConstants.emailInvalidError;
    }

    return null;
  }

  /// Validiert die "Über mich" Beschreibung
  ///
  /// [about] - Die zu validierende Beschreibung
  ///
  /// Returns: Fehlermeldung oder null wenn gültig
  static String? validateAbout(String? about) {
    if (about != null && about.trim().length > AppConstants.aboutMaxLength) {
      return AppConstants.aboutMaxLengthError;
    }

    return null;
  }

  /// Normalisiert und bereinigt einen Namen
  ///
  /// [name] - Der zu bereinigende Name
  ///
  /// Returns: Bereinigter Name
  static String sanitizeName(String? name) {
    return name?.trim() ?? '';
  }

  /// Normalisiert und bereinigt eine E-Mail
  ///
  /// [email] - Die zu bereinigende E-Mail
  ///
  /// Returns: Bereinigte E-Mail (lowercase, getrimmt)
  static String sanitizeEmail(String? email) {
    return email?.trim().toLowerCase() ?? '';
  }

  /// Normalisiert und bereinigt eine Beschreibung
  ///
  /// [about] - Die zu bereinigende Beschreibung
  ///
  /// Returns: Bereinigte Beschreibung
  static String sanitizeAbout(String? about) {
    return about?.trim() ?? '';
  }
}
