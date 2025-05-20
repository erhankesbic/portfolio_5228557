import 'package:flutter/material.dart';
import 'profile_form_page.dart';
import 'slider_page.dart';
import 'settings_page.dart';
import 'summary_page.dart';
import 'user_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = '';
  String email = '';
  String about = '';
  double sliderValue = 50.0;
  bool newsletter = false;
  bool darkMode = false;
  bool notifications = false;
  bool offlineMode = false;

  void updateProfile(String newName, String newEmail, String newAbout) {
    setState(() {
      name = newName;
      email = newEmail;
      about = newAbout;
    });
  }

  void updateSliderValue(double newValue) {
    setState(() {
      sliderValue = newValue;
    });
  }

  void updateSettings({
    required bool newsletter,
    required bool darkMode,
    required bool notifications,
    required bool offlineMode,
  }) {
    setState(() {
      this.newsletter = newsletter;
      this.darkMode = darkMode;
      this.notifications = notifications;
      this.offlineMode = offlineMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mein Portfolio')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name.isNotEmpty ? 'Willkommen, $name' : 'Willkommen im Portfolio',
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProfileFormPage(
                      initialName: name,
                      initialEmail: email,
                    ),
                  ),
                );
                if (result is Map<String, String>) {
                  updateProfile(
                    result['name'] ?? '',
                    result['email'] ?? '',
                    result['about'] ?? '',
                  );
                }
              },
              child: const Text('Profilseite'),
            ),
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SliderPage(initialValue: sliderValue),
                  ),
                );
                if (result is double) {
                  updateSliderValue(result);
                }
              },
              child: const Text('Slider-Seite'),
            ),
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SettingsPage(
                      initialNewsletter: newsletter,
                      initialDarkMode: darkMode,
                      initialNotifications: notifications,
                      initialOfflineMode: offlineMode,
                    ),
                  ),
                );
                if (result is Map) {
                  updateSettings(
                    newsletter: result['newsletter'] ?? false,
                    darkMode: result['darkMode'] ?? false,
                    notifications: result['notifications'] ?? false,
                    offlineMode: result['offlineMode'] ?? false,
                  );
                }
              },
              child: const Text('Einstellungen'),
            ),
            ElevatedButton(
              onPressed: () {
                final userData = UserData(
                  name: name,
                  email: email,
                  about: about,
                  sliderValue: sliderValue,
                  newsletter: newsletter,
                  darkMode: darkMode,
                  notifications: notifications,
                  offlineMode: offlineMode,
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