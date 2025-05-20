import 'package:flutter/material.dart';

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
      appBar: AppBar(title: const Text('Profil bearbeiten')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(labelText: 'Name'),
                onSaved: (value) => _name = value ?? '',
                validator: (value) =>
                    value == null || value.isEmpty ? 'Bitte Namen eingeben' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _email,
                decoration: const InputDecoration(labelText: 'E-Mail-Adresse'),
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) => _email = value ?? '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bitte E-Mail eingeben';
                  }
                  final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Bitte gültige E-Mail-Adresse eingeben';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _about,
                decoration: const InputDecoration(
                  labelText: 'Über mich',
                  alignLabelWithHint: true,
                ),
                maxLines: 5,
                onSaved: (value) => _about = value ?? '',
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  final isValid = _formKey.currentState?.validate() ?? false;
                  if (isValid) {
                    _formKey.currentState?.save();

                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Eingegebene Daten'),
                        content: Text('Name: $_name\nEmail: $_email\nÜber mich: $_about'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Dialog schließen
                              Navigator.pop(context, {
                                'name': _name,
                                'email': _email,
                                'about': _about,
                              }); // Seite schließen und Daten zurückgeben
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: const Text('Speichern'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}