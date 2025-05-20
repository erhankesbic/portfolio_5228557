import 'package:flutter/material.dart';
import 'profile_form_page.dart';
import 'slider_page.dart';
import 'settings_page.dart';
import 'summary_page.dart';
import 'user_data.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mein Portfolio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Willkommen im Portfolio von Erhan',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfileFormPage()),
                );
              },
              child: const Text('Profilseite'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SliderPage()),
                );
              },
              child: const Text('Slider-Seite'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsPage()),
                );
              },
              child: const Text('Einstellungen'),
            ),
            ElevatedButton(
              onPressed: () {
                // Beispiel-Daten für die Zusammenfassungsseite
                final userData = UserData(
                  name: 'Erhan Kesbic',
                  email: 'erhan@example.com',
                  sliderValue: 42.0,
                  newsletter: true,
                  darkMode: true,
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SummaryPage(data: userData),
                  ),
                );
              },
              child: const Text('Zusammenfassung'),
            ),
          ],
        ),
      ),
    );
  }
}