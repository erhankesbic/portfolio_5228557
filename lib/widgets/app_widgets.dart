import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Wiederverwendbare UI-Komponenten für die gesamte App
///
/// Diese Klasse enthält häufig verwendete Widgets, die konsistent
/// in der gesamten Anwendung eingesetzt werden können.
class AppWidgets {
  // Private Konstruktor verhindert Instanziierung
  AppWidgets._();

  /// Standard Benutzer-Avatar
  ///
  /// [radius] - Radius des Avatars (default: medium)
  /// [backgroundColor] - Hintergrundfarbe (default: primaryLight)
  /// [iconColor] - Icon-Farbe (default: primaryDark)
  /// [icon] - Icon das angezeigt werden soll (default: person)
  static Widget userAvatar({
    double? radius,
    Color? backgroundColor,
    Color? iconColor,
    IconData? icon,
  }) {
    final double avatarRadius = radius ?? AppTheme.avatarMedium;

    return CircleAvatar(
      radius: avatarRadius,
      backgroundColor: backgroundColor ?? AppTheme.primaryLight,
      child: Icon(
        icon ?? Icons.person,
        size: avatarRadius + 8,
        color: iconColor ?? AppTheme.primaryDark,
      ),
    );
  }

  /// Standard App-Button mit Icon
  ///
  /// [icon] - Icon für den Button
  /// [label] - Button-Text
  /// [onPressed] - Callback-Funktion
  /// [style] - Optionales Button-Style
  /// [width] - Button-Breite (default: medium)
  /// [height] - Button-Höhe (default: standard)
  static Widget iconButton({
    required IconData icon,
    required String label,
    required VoidCallback? onPressed,
    ButtonStyle? style,
    double? width,
    double? height,
  }) {
    return ElevatedButton.icon(
      icon: Icon(icon),
      onPressed: onPressed,
      label: Text(label),
      style:
          style ??
          ElevatedButton.styleFrom(
            minimumSize: Size(
              width ?? AppTheme.buttonMediumWidth,
              height ?? AppTheme.buttonHeight,
            ),
          ),
    );
  }

  /// Standard Text-Button
  ///
  /// [label] - Button-Text
  /// [onPressed] - Callback-Funktion
  /// [style] - Optionales Button-Style
  static Widget textButton({
    required String label,
    required VoidCallback? onPressed,
    ButtonStyle? style,
  }) {
    return TextButton(onPressed: onPressed, style: style, child: Text(label));
  }

  /// Standard Input-Feld
  ///
  /// [controller] - Text-Controller
  /// [labelText] - Label für das Feld
  /// [hintText] - Hint-Text
  /// [prefixIcon] - Icon vor dem Text
  /// [validator] - Validierungs-Funktion
  /// [maxLines] - Maximale Zeilen (default: 1)
  /// [keyboardType] - Tastatur-Typ
  static Widget textField({
    TextEditingController? controller,
    required String labelText,
    String? hintText,
    IconData? prefixIcon,
    String? Function(String?)? validator,
    int? maxLines = 1,
    TextInputType? keyboardType,
    int? maxLength,
    void Function(String?)? onSaved,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingMedium,
          vertical: AppTheme.spacingMedium,
        ),
      ),
      validator: validator,
      maxLines: maxLines,
      keyboardType: keyboardType,
      maxLength: maxLength,
      onSaved: onSaved,
    );
  }

  /// Standard Spacing Widget
  ///
  /// [height] - Vertikaler Abstand (default: medium)
  /// [width] - Horizontaler Abstand (default: medium)
  static Widget spacing({double? height, double? width}) {
    return SizedBox(
      height: height ?? AppTheme.spacingMedium,
      width: width ?? AppTheme.spacingMedium,
    );
  }

  /// Standard Card-Container
  ///
  /// [child] - Kind-Widget
  /// [padding] - Padding innerhalb der Card
  /// [margin] - Margin um die Card
  /// [elevation] - Schatten-Tiefe
  static Widget card({
    required BuildContext context,
    required Widget child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? elevation,
  }) {
    return Card(
      color: Theme.of(context).cardColor,
      elevation: elevation ?? 2,
      margin: margin ?? const EdgeInsets.all(AppTheme.spacingSmall),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(AppTheme.spacingMedium),
        child: child,
      ),
    );
  }

  /// Standard Section-Header
  ///
  /// [title] - Titel-Text
  /// [subtitle] - Optionaler Untertitel
  /// [style] - Optionales Text-Style
  static Widget sectionHeader({
    required String title,
    String? subtitle,
    TextStyle? style,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: style ?? AppTheme.titleLarge),
        if (subtitle != null) ...[
          spacing(height: AppTheme.spacingXSmall),
          Text(
            subtitle,
            style: AppTheme.bodyMedium.copyWith(color: AppTheme.textSecondary),
          ),
        ],
      ],
    );
  }

  /// Loading Indikator
  ///
  /// [message] - Optionale Lade-Nachricht
  static Widget loading({String? message}) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          if (message != null) ...[
            spacing(height: AppTheme.spacingMedium),
            Text(
              message,
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Error Widget
  ///
  /// [message] - Fehler-Nachricht
  /// [onRetry] - Retry-Callback
  static Widget error({required String message, VoidCallback? onRetry}) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            size: AppTheme.iconLarge,
            color: AppTheme.errorColor,
          ),
          spacing(height: AppTheme.spacingMedium),
          Text(
            message,
            style: AppTheme.bodyMedium.copyWith(color: AppTheme.textSecondary),
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            spacing(height: AppTheme.spacingMedium),
            textButton(label: 'Erneut versuchen', onPressed: onRetry),
          ],
        ],
      ),
    );
  }

  /// Empty State Widget
  ///
  /// [message] - Nachricht für leeren Zustand
  /// [icon] - Icon für leeren Zustand
  /// [action] - Optionale Aktion
  static Widget emptyState({
    required String message,
    IconData? icon,
    Widget? action,
  }) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon ?? Icons.inbox_outlined,
            size: AppTheme.iconLarge,
            color: AppTheme.textHint,
          ),
          spacing(height: AppTheme.spacingMedium),
          Text(
            message,
            style: AppTheme.bodyLarge.copyWith(color: AppTheme.textSecondary),
            textAlign: TextAlign.center,
          ),
          if (action != null) ...[
            spacing(height: AppTheme.spacingLarge),
            action,
          ],
        ],
      ),
    );
  }
}
