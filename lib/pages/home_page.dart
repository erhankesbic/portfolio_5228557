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
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.blue.shade100,
                  child: Icon(Icons.person, size: 48, color: Colors.blue.shade700),
                ),
                const SizedBox(height: 24),
                Text(
                  name.isNotEmpty ? 'Willkommen, $name!' : 'Willkommen im Portfolio',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                if (email.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      email,
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                  ),
                if (about.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      about,
                      style: TextStyle(fontSize: 15, color: Colors.grey[600], fontStyle: FontStyle.italic),
                      textAlign: TextAlign.center,
                    ),
                  ),
                const SizedBox(height: 36),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.edit),
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProfileFormPage(
                              initialName: name,
                              initialEmail: email,
                              initialAbout: about,
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
                      label: const Text('Profilseite'),
                      style: ElevatedButton.styleFrom(minimumSize: const Size(160, 48)),
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.tune),
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
                      label: const Text('Slider-Seite'),
                      style: ElevatedButton.styleFrom(minimumSize: const Size(160, 48)),
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.settings),
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
                      label: const Text('Einstellungen'),
                      style: ElevatedButton.styleFrom(minimumSize: const Size(160, 48)),
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.summarize),
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
                      label: const Text('Zusammenfassung'),
                      style: ElevatedButton.styleFrom(minimumSize: const Size(160, 48)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}