// summary_page.dart
import 'package:flutter/material.dart';
import 'user_data.dart';

class SummaryPage extends StatelessWidget {
  final UserData data;

  const SummaryPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zusammenfassung'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 24),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.person, color: Colors.blue, size: 28),
                            const SizedBox(width: 10),
                            const Text(
                              'Profilinformationen',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text('Name: ${data.name}', style: const TextStyle(fontSize: 16)),
                        Text('E-Mail: ${data.email}', style: const TextStyle(fontSize: 16)),
                        if (data.about.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Text('Über mich: ${data.about}', style: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic, color: Colors.black87)),
                          ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 24),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.tune, color: Colors.deepPurple, size: 28),
                            const SizedBox(width: 10),
                            const Text(
                              'Slider-Wert',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text('Wert: ${data.sliderValue.toInt()}', style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.settings, color: Colors.teal, size: 28),
                            const SizedBox(width: 10),
                            const Text(
                              'Einstellungen',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text('Newsletter: ${data.newsletter ? "Abonniert" : "Nicht abonniert"}', style: const TextStyle(fontSize: 16)),
                        Text('Dunkler Modus: ${data.darkMode ? "Aktiviert" : "Deaktiviert"}', style: const TextStyle(fontSize: 16)),
                        Text('Benachrichtigungen: ${data.notifications ? "Aktiviert" : "Deaktiviert"}', style: const TextStyle(fontSize: 16)),
                        Text('Offline-Modus: ${data.offlineMode ? "Aktiviert" : "Deaktiviert"}', style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}