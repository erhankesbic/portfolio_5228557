import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../widgets/app_widgets.dart';
import '../widgets/app_scaffold.dart';
import '../viewmodels/home_view_model.dart';

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
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _aboutController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _emailController = TextEditingController(text: widget.initialEmail);
    _aboutController = TextEditingController(text: widget.initialAbout);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Profil bearbeiten',
      body: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingXLarge),
        child: AppWidgets.card(context: context,
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacingLarge),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppWidgets.textField(
                    controller: _nameController,
                    labelText: 'Name',
                    prefixIcon: Icons.person,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Bitte Namen eingeben.';
                      }
                      return null;
                    },
                    onSaved: (value) => _nameController.text = value ?? '',
                  ),
                  AppWidgets.spacing(height: AppTheme.spacingMedium),
                  AppWidgets.textField(
                    controller: _emailController,
                    labelText: 'E-Mail-Adresse',
                    prefixIcon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Bitte E-Mail eingeben.';
                      }
                      final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.[a-zA-Z]{2,}$');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Ungültige E-Mail-Adresse';
                      }
                      return null;
                    },
                    onSaved: (value) => _emailController.text = value ?? '',
                  ),
                  AppWidgets.spacing(height: AppTheme.spacingMedium),
                  AppWidgets.textField(
                    controller: _aboutController,
                    labelText: 'Über mich',
                    prefixIcon: Icons.info_outline,
                    maxLines: 4,
                    maxLength: 500,
                    onSaved: (value) => _aboutController.text = value ?? '',
                  ),
                  AppWidgets.spacing(height: AppTheme.spacingXLarge),
                  AppWidgets.textButton(
                    label: 'Speichern',
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _formKey.currentState?.save();
                        Provider.of<HomeViewModel>(context, listen: false).updateProfile(
                          _nameController.text,
                          _emailController.text,
                          _aboutController.text,
                        );
                        Navigator.pop(context);
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
