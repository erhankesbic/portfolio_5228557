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
    return WillPopScope(
      onWillPop: () async {
        _saveSettings();
        return false;
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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Checkboxen
              CheckboxListTile(
                title: const Text('Newsletter abonnieren'),
                value: isNewsletterSubscribed,
                onChanged: (value) {
                  setState(() {
                    isNewsletterSubscribed = value!;
                  });
                },
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

              const SizedBox(height: 20),

              // Switches
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

              const Spacer(),

              // Zusammenfassung
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Aktuelle Einstellungen:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text('Newsletter: ${isNewsletterSubscribed ? "Ja" : "Nein"}'),
                      Text('Benachrichtigungen: ${isNotificationsEnabled ? "Ja" : "Nein"}'),
                      Text('Dunkler Modus: ${isDarkMode ? "Aktiviert" : "Deaktiviert"}'),
                      Text('Offline-Modus: ${isOfflineMode ? "Aktiviert" : "Deaktiviert"}'),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}