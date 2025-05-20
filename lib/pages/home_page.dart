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

  void updateProfile(String newName, String newEmail) {
    setState(() {
      name = newName;
      email = newEmail;
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
              name.isNotEmpty ? 'Willkommen, $name' : 'Willkommen im Portfolio von Erhan',
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
                  updateProfile(result['name'] ?? '', result['email'] ?? '');
                }
              },
              child: const Text('Profilseite'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const SliderPage()));
              },
              child: const Text('Slider-Seite'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsPage()));
              },
              child: const Text('Einstellungen'),
            ),
            ElevatedButton(
              onPressed: () {
                final userData = UserData(
                  name: name,
                  email: email,
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