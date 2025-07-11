import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_widgets.dart';
import '../widgets/app_scaffold.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Hier würde die Logik zum Senden der E-Mail stehen.
      // Stattdessen zeigen wir eine SnackBar an.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Nachricht erfolgreich versendet!'),
          backgroundColor: AppTheme.successColor,
        ),
      );

      // Formular zurücksetzen
      _formKey.currentState!.reset();
      _nameController.clear();
      _emailController.clear();
      _subjectController.clear();
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Kontakt',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingLarge),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppWidgets.textField(
                controller: _nameController,
                labelText: 'Name',
                prefixIcon: Icons.person,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bitte geben Sie Ihren Namen ein.';
                  }
                  return null;
                },
              ),
              AppWidgets.spacing(height: AppTheme.spacingMedium),
              AppWidgets.textField(
                controller: _emailController,
                labelText: 'E-Mail',
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bitte geben Sie Ihre E-Mail-Adresse ein.';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Bitte geben Sie eine gültige E-Mail-Adresse ein.';
                  }
                  return null;
                },
              ),
              AppWidgets.spacing(height: AppTheme.spacingMedium),
              AppWidgets.textField(
                controller: _subjectController,
                labelText: 'Betreff',
                prefixIcon: Icons.subject,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bitte geben Sie einen Betreff ein.';
                  }
                  return null;
                },
              ),
              AppWidgets.spacing(height: AppTheme.spacingMedium),
              AppWidgets.textField(
                controller: _messageController,
                labelText: 'Nachricht',
                prefixIcon: Icons.message,
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bitte geben Sie eine Nachricht ein.';
                  }
                  return null;
                },
              ),
              AppWidgets.spacing(height: AppTheme.spacingLarge),
              ElevatedButton.icon(
                icon: const Icon(Icons.send),
                label: const Text('Senden'),
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingMedium),
                  textStyle: AppTheme.titleMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
