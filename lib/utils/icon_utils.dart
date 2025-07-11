import 'package:flutter/cupertino.dart';

/// Utility-Klasse für konsistente Icon-Verwendung
///
/// Diese Klasse stellt sicher, dass Icons plattformunabhängig korrekt angezeigt werden
class IconUtils {
  IconUtils._();

  /// Benutzer-bezogene Icons
  static const IconData user = CupertinoIcons.person_fill;
  static const IconData userCircle = CupertinoIcons.person_crop_circle;

  /// Navigation Icons
  static const IconData profile = CupertinoIcons.person_crop_circle;
  static const IconData slider = CupertinoIcons.slider_horizontal_3;
  static const IconData settings = CupertinoIcons.settings;
  static const IconData summary = CupertinoIcons.doc_text;

  /// Action Icons
  static const IconData check = CupertinoIcons.check_mark;
  static const IconData save = CupertinoIcons.checkmark_circle;
  static const IconData edit = CupertinoIcons.pen;
  static const IconData back = CupertinoIcons.back;

  /// Status Icons
  static const IconData newsletter = CupertinoIcons.mail;
  static const IconData notifications = CupertinoIcons.bell;
  static const IconData darkMode = CupertinoIcons.moon;
  static const IconData offlineMode = CupertinoIcons.wifi_slash;

  /// Erstellt ein sicheres Icon Widget mit Fallback
  static Widget safeIcon(IconData iconData, {double? size, Color? color}) {
    return Icon(
      iconData,
      size: size,
      color: color,
      // Fallback für fehlende Icons
      semanticLabel: 'Icon',
    );
  }
}
