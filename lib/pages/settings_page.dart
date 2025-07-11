import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  final bool initialNewsletter;
  final bool initialDarkMode;
  final bool initialNotifications;
  final bool initialOfflineMode;

  const SettingsPage({
    super.key,
    required this.initialNewsletter,
    required this.initialDarkMode,
    required this.initialNotifications,
    required this.initialOfflineMode,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late bool isNewsletterSubscribed;
  late bool isDarkMode;
  late bool isNotificationsEnabled;
  late bool isOfflineMode;

  @override
  void initState() {
    super.initState();
    isNewsletterSubscribed = widget.initialNewsletter;
    isDarkMode = widget.initialDarkMode;
    isNotificationsEnabled = widget.initialNotifications;
    isOfflineMode = widget.initialOfflineMode;
  }

  void _saveSettings() {
    Navigator.pop(context, {
      'newsletter': isNewsletterSubscribed,
      'darkMode': isDarkMode,
      'notifications': isNotificationsEnabled,
      'offlineMode': isOfflineMode,
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _saveSettings();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Einstellungen'),
          actions: [
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: _saveSettings,
            ),
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 24),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.email, color: Colors.blue, size: 24),
                              const SizedBox(width: 8),
                              const Text('Newsletter', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          CheckboxListTile(
                            title: const Text('Newsletter abonnieren'),
                            value: isNewsletterSubscribed,
                            onChanged: (value) {
                              setState(() {
                                isNewsletterSubscribed = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 24),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.notifications, color: Colors.deepPurple, size: 24),
                              const SizedBox(width: 8),
                              const Text('Benachrichtigungen', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          CheckboxListTile(
                            title: const Text('Benachrichtigungen aktivieren'),
                            value: isNotificationsEnabled,
                            onChanged: (value) {
                              setState(() {
                                isNotificationsEnabled = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 24),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.dark_mode, color: Colors.teal, size: 24),
                              const SizedBox(width: 8),
                              const Text('Darstellung', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          SwitchListTile(
                            title: const Text('Dunkler Modus'),
                            value: isDarkMode,
                            onChanged: (value) {
                              setState(() {
                                isDarkMode = value;
                              });
                            },
                          ),
                          SwitchListTile(
                            title: const Text('Offline-Modus'),
                            value: isOfflineMode,
                            onChanged: (value) {
                              setState(() {
                                isOfflineMode = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.save),
                    label: const Text('Einstellungen speichern'),
                    style: ElevatedButton.styleFrom(minimumSize: const Size(180, 48)),
                    onPressed: _saveSettings,
                  ),
                  const SizedBox(height: 32),
                  Card(
                    elevation: 2,
                    color: Colors.grey[50],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Aktuelle Auswahl:',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text('Newsletter: ${isNewsletterSubscribed ? "Abonniert" : "Nicht abonniert"}'),
                          Text('Benachrichtigungen: ${isNotificationsEnabled ? "Aktiviert" : "Deaktiviert"}'),
                          Text('Dunkler Modus: ${isDarkMode ? "Aktiviert" : "Deaktiviert"}'),
                          Text('Offline-Modus: ${isOfflineMode ? "Aktiviert" : "Deaktiviert"}'),
                        ],
                      ),
                    ),
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