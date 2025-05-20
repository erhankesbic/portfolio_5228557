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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '👤 Profilinformationen',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Name: ${data.name}'),
            Text('E-Mail: ${data.email}'),
            const SizedBox(height: 16),

            const Text(
              '🎚️ Slider-Wert',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Wert: ${data.sliderValue.toStringAsFixed(1)}'),
            const SizedBox(height: 16),

            const Text(
              '⚙️ Einstellungen',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Newsletter: ${data.newsletter ? "Abonniert" : "Nicht abonniert"}'),
            Text('Dunkler Modus: ${data.darkMode ? "Aktiviert" : "Deaktiviert"}'),
          ],
        ),
      ),
    );
  }
}