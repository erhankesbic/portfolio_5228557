import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_widgets.dart';

/// Konstanten für die Profilformular-Seite
class ProfileFormConstants {
  static const double formPadding = 16.0;
  static const double fieldSpacing = 16.0;
  static const double buttonSpacing = 24.0;
  static const int maxNameLength = 50;
  static const int maxEmailLength = 100;
  static const int maxAboutLength = 500;
}

/// Seite für die Bearbeitung von Profilinformationen
///
/// Ermöglicht Benutzern das Eingeben und Validieren von:
/// - Name (Pflichtfeld, 2-50 Zeichen)
/// - E-Mail (Pflichtfeld, gültige E-Mail-Adresse)
/// - Über mich (Optional, max. 500 Zeichen)
class ProfileFormPage extends StatefulWidget {
  final String initialName;
  final String initialEmail;
  final String initialAbout;

  const ProfileFormPage({
    super.key,
    this.initialName = '',
    this.initialEmail = '',
    this.initialAbout = '',
  });

  @override
  State<ProfileFormPage> createState() => _ProfileFormPageState();
}

class _ProfileFormPageState extends State<ProfileFormPage> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _email;
  late String _about;

  @override
  void initState() {
    super.initState();
    _name = widget.initialName;
    _email = widget.initialEmail;
    _about = widget.initialAbout;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil bearbeiten'),
        elevation: 0,
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingXLarge),
        child: AppWidgets.card(
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacingLarge),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    initialValue: _name,
                    decoration: const InputDecoration(labelText: 'Name'),
                    onSaved: (value) => _name = value ?? '',
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? 'Bitte Namen eingeben'
                                : null,
                  ),
                  AppWidgets.spacing(height: AppTheme.spacingMedium),
                  TextFormField(
                    initialValue: _email,
                    decoration: const InputDecoration(
                      labelText: 'E-Mail-Adresse',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (value) => _email = value ?? '',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Bitte E-Mail eingeben';
                      }
                      final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Ungültige E-Mail-Adresse';
                      }
                      return null;
                    },
                  ),
                  AppWidgets.spacing(height: AppTheme.spacingMedium),
                  TextFormField(
                    initialValue: _about,
                    decoration: const InputDecoration(labelText: 'Über mich'),
                    maxLines: 4,
                    maxLength: 500,
                    onSaved: (value) => _about = value ?? '',
                  ),
                  AppWidgets.spacing(height: AppTheme.spacingXLarge),
                  AppWidgets.textButton(
                    label: 'Speichern',
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _formKey.currentState?.save();
                        Navigator.pop(context, {
                          'name': _name,
                          'email': _email,
                          'about': _about,
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
