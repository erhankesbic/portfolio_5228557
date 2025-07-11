import 'package:flutter/foundation.dart';

/// Exception-Typen für bessere Fehlerbehandlung
enum ErrorType {
  network,
  validation,
  permission,
  storage,
  unknown,
}

/// Basis-Exception-Klasse für die App
class AppException implements Exception {
  final String message;
  final ErrorType type;
  final String? details;
  final StackTrace? stackTrace;

  const AppException({
    required this.message,
    required this.type,
    this.details,
    this.stackTrace,
  });

  @override
  String toString() {
    return 'AppException: $message (Type: $type)';
  }
}

/// Validierungs-Exception
class ValidationException extends AppException {
  ValidationException({
    required super.message,
    super.details,
    super.stackTrace,
  }) : super(type: ErrorType.validation);
}

/// Netzwerk-Exception
class NetworkException extends AppException {
  NetworkException({
    required super.message,
    super.details,
    super.stackTrace,
  }) : super(type: ErrorType.network);
}

/// Storage-Exception
class StorageException extends AppException {
  StorageException({
    required super.message,
    super.details,
    super.stackTrace,
  }) : super(type: ErrorType.storage);
}

/// Zentraler Error Handler Service
/// 
/// Dieser Service behandelt alle Fehler in der App einheitlich
/// und stellt benutzerfreundliche Fehlermeldungen bereit.
class ErrorHandlerService {
  // Singleton Pattern
  static final ErrorHandlerService _instance = ErrorHandlerService._internal();
  factory ErrorHandlerService() => _instance;
  ErrorHandlerService._internal();

  /// Behandelt einen Fehler und gibt eine benutzerfreundliche Nachricht zurück
  /// 
  /// [error] - Der aufgetretene Fehler
  /// [stackTrace] - Optional: Stack Trace für Debugging
  /// [context] - Optional: Zusätzlicher Kontext für den Fehler
  String handleError(
    dynamic error, {
    StackTrace? stackTrace,
    String? context,
  }) {
    // Debug-Modus: Detaillierte Logs
    if (kDebugMode) {
      debugPrint('=== ERROR HANDLER ===');
      debugPrint('Context: ${context ?? 'Unknown'}');
      debugPrint('Error: $error');
      debugPrint('Type: ${error.runtimeType}');
      if (stackTrace != null) {
        debugPrint('StackTrace: $stackTrace');
      }
      debugPrint('====================');
    }

    // Fehler-spezifische Behandlung
    if (error is AppException) {
      return _handleAppException(error);
    }

    if (error is FormatException) {
      return 'Ungültiges Datenformat. Bitte überprüfen Sie Ihre Eingabe.';
    }

    if (error is ArgumentError) {
      return 'Ungültige Parameter. Bitte überprüfen Sie Ihre Eingabe.';
    }

    // Fallback für unbekannte Fehler
    return 'Ein unerwarteter Fehler ist aufgetreten. Bitte versuchen Sie es erneut.';
  }

  /// Behandelt App-spezifische Exceptions
  String _handleAppException(AppException exception) {
    switch (exception.type) {
      case ErrorType.validation:
        return exception.message;
      
      case ErrorType.network:
        return 'Netzwerkfehler: ${exception.message}';
      
      case ErrorType.storage:
        return 'Speicherfehler: ${exception.message}';
      
      case ErrorType.permission:
        return 'Berechtigung fehlt: ${exception.message}';
      
      case ErrorType.unknown:
        return exception.message;
    }
  }

  /// Loggt einen Fehler für Debugging/Analytics
  /// 
  /// [error] - Der Fehler
  /// [stackTrace] - Stack Trace
  /// [context] - Kontext-Information
  void logError(
    dynamic error, {
    StackTrace? stackTrace,
    String? context,
    Map<String, dynamic>? additionalData,
  }) {
    if (kDebugMode) {
      debugPrint('=== ERROR LOG ===');
      debugPrint('Time: ${DateTime.now().toIso8601String()}');
      debugPrint('Context: ${context ?? 'Unknown'}');
      debugPrint('Error: $error');
      debugPrint('Type: ${error.runtimeType}');
      
      if (additionalData != null) {
        debugPrint('Additional Data: $additionalData');
      }
      
      if (stackTrace != null) {
        debugPrint('StackTrace: $stackTrace');
      }
      debugPrint('================');
    }

    // TODO: In einer echten App würde hier Analytics/Crashlytics aufgerufen
    // FirebaseCrashlytics.instance.recordError(error, stackTrace);
  }

  /// Zeigt einen benutzerfreundlichen Fehler-Dialog
  /// 
  /// [error] - Der Fehler
  /// [onRetry] - Optional: Retry-Callback
  String getDisplayMessage(dynamic error) {
    return handleError(error);
  }

  /// Prüft ob ein Fehler als kritisch eingestuft werden sollte
  bool isCriticalError(dynamic error) {
    if (error is AppException) {
      return error.type == ErrorType.storage || 
             error.type == ErrorType.permission;
    }
    return false;
  }

  /// Erstellt eine App-Exception mit Kontext-Informationen
  AppException createException({
    required String message,
    required ErrorType type,
    String? details,
    String? context,
    StackTrace? stackTrace,
  }) {
    final contextualMessage = context != null 
        ? '$context: $message' 
        : message;

    return AppException(
      message: contextualMessage,
      type: type,
      details: details,
      stackTrace: stackTrace ?? StackTrace.current,
    );
  }
}
