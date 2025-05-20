import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Checkboxen
  bool isNewsletterSubscribed = false;
  bool isNotificationsEnabled = false;

  // Switches
  bool isDarkMode = false;
  bool isOfflineMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Einstellungen'),
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
    );
  }
}