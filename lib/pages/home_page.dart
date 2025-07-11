import 'package:flutter/material.dart';
import 'profile_form_page.dart';
import 'slider_page.dart';
import 'settings_page.dart';
import 'summary_page.dart';
import 'user_data.dart';

// Konstanten für bessere Wartbarkeit
class AppConstants {
  static const double avatarRadius = 40.0;
  static const double mainPadding = 32.0;
  static const double buttonSpacing = 16.0;
  static const double buttonHeight = 48.0;
  static const double buttonWidth = 160.0;
  static const double headerFontSize = 22.0;
  static const double subHeaderFontSize = 16.0;
  static const double smallFontSize = 15.0;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Zustandsvariablen für Benutzerdaten
  String name = '';
  String email = '';
  String about = '';
  double sliderValue = 50.0;
  bool newsletter = false;
  bool darkMode = false;
  bool notifications = false;
  bool offlineMode = false;

  /// Aktualisiert die Profildaten des Benutzers
  void updateProfile(String newName, String newEmail, String newAbout) {
    setState(() {
      name = newName;
      email = newEmail;
      about = newAbout;
    });
  }

  /// Aktualisiert den Slider-Wert
  void updateSliderValue(double newValue) {
    setState(() {
      sliderValue = newValue;
    });
  }

  /// Aktualisiert alle Einstellungen auf einmal
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

  /// Erstellt das Benutzer-Avatar Widget
  Widget _buildUserAvatar() {
    return CircleAvatar(
      radius: AppConstants.avatarRadius,
      backgroundColor: Colors.blue.shade100,
      child: Icon(
        Icons.person, 
        size: AppConstants.avatarRadius + 8, 
        color: Colors.blue.shade700
      ),
    );
  }

  /// Erstellt den Willkommens-Text
  Widget _buildWelcomeText() {
    return Text(
      name.isNotEmpty ? 'Willkommen, $name!' : 'Willkommen im Portfolio',
      style: const TextStyle(
        fontSize: AppConstants.headerFontSize, 
        fontWeight: FontWeight.bold
      ),
      textAlign: TextAlign.center,
    );
  }

  /// Erstellt die Benutzerinformationen (E-Mail und Beschreibung)
  Widget _buildUserInfo() {
    return Column(
      children: [
        if (email.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              email,
              style: TextStyle(
                fontSize: AppConstants.subHeaderFontSize, 
                color: Colors.grey[700]
              ),
            ),
          ),
        if (about.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              about,
              style: TextStyle(
                fontSize: AppConstants.smallFontSize, 
                color: Colors.grey[600], 
                fontStyle: FontStyle.italic
              ),
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }

  /// Erstellt einen Navigation-Button
  Widget _buildNavigationButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      icon: Icon(icon),
      onPressed: onPressed,
      label: Text(label),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(
          AppConstants.buttonWidth, 
          AppConstants.buttonHeight
        )
      ),
    );
  }

  /// Navigiert zur Profilseite
  Future<void> _navigateToProfile() async {
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
  }

  /// Navigiert zur Slider-Seite
  Future<void> _navigateToSlider() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SliderPage(initialValue: sliderValue),
      ),
    );
    if (result is double) {
      updateSliderValue(result);
    }
  }

  /// Navigiert zu den Einstellungen
  Future<void> _navigateToSettings() async {
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
  }

  /// Navigiert zur Zusammenfassungsseite
  void _navigateToSummary() {
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
  }

  /// Erstellt alle Navigation-Buttons
  Widget _buildNavigationButtons() {
    return Wrap(
      spacing: AppConstants.buttonSpacing,
      runSpacing: AppConstants.buttonSpacing,
      alignment: WrapAlignment.center,
      children: [
        _buildNavigationButton(
          icon: Icons.edit,
          label: 'Profilseite',
          onPressed: _navigateToProfile,
        ),
        _buildNavigationButton(
          icon: Icons.tune,
          label: 'Slider-Seite',
          onPressed: _navigateToSlider,
        ),
        _buildNavigationButton(
          icon: Icons.settings,
          label: 'Einstellungen',
          onPressed: _navigateToSettings,
        ),
        _buildNavigationButton(
          icon: Icons.summarize,
          label: 'Zusammenfassung',
          onPressed: _navigateToSummary,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mein Portfolio')),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.mainPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildUserAvatar(),
                const SizedBox(height: 24),
                _buildWelcomeText(),
                _buildUserInfo(),
                const SizedBox(height: 36),
                _buildNavigationButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}