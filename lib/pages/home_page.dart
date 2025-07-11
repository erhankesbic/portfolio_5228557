import 'package:flutter/material.dart';
import 'profile_form_page.dart';
import 'slider_page.dart';
import 'settings_page.dart';
import 'summary_page.dart';
import 'work_page.dart';
import 'about_page.dart';
import '../models/user_data.dart';
import '../repositories/user_repository.dart';
import '../utils/icon_utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Repository für Benutzerdaten-Management
  final UserRepository _userRepository = UserRepository();

  // Getter für einfachen Zugriff auf Benutzerdaten
  UserData get _currentUser => _userRepository.currentUser;

  /// Aktualisiert die Profildaten des Benutzers
  void updateProfile(String newName, String newEmail, String newAbout) {
    setState(() {
      _userRepository.updateProfile(
        name: newName,
        email: newEmail,
        about: newAbout,
      );
    });
  }

  /// Aktualisiert den Slider-Wert
  void updateSliderValue(double newValue) {
    setState(() {
      _userRepository.updateSliderValue(newValue);
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
      _userRepository.updateSettings(
        newsletter: newsletter,
        darkMode: darkMode,
        notifications: notifications,
        offlineMode: offlineMode,
      );
    });
  }

  /// Erstellt das Benutzer-Avatar Widget
  Widget _buildUserAvatar() {
    return CircleAvatar(
      radius: 40.0,
      backgroundColor: Colors.blue.shade100,
      child: IconUtils.safeIcon(
        IconUtils.user,
        size: 48.0,
        color: Colors.blue.shade700,
      ),
    );
  }

  /// Erstellt den Willkommens-Text
  Widget _buildWelcomeText() {
    final userName = _currentUser.name;
    final welcomeText =
        userName.isNotEmpty
            ? 'Willkommen, $userName!'
            : 'Willkommen im Portfolio';

    return Text(
      welcomeText,
      style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  /// Erstellt die Benutzerinformationen (E-Mail und Beschreibung)
  Widget _buildUserInfo() {
    return Column(
      children: [
        if (_currentUser.email.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              _currentUser.email,
              style: TextStyle(fontSize: 16.0, color: Colors.grey[700]),
            ),
          ),
        if (_currentUser.about.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              _currentUser.about,
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
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
      style: ElevatedButton.styleFrom(minimumSize: const Size(160.0, 48.0)),
    );
  }

  /// Navigiert zur Profilseite
  Future<void> _navigateToProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => ProfileFormPage(
              initialName: _currentUser.name,
              initialEmail: _currentUser.email,
              initialAbout: _currentUser.about,
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
        builder: (_) => SliderPage(initialValue: _currentUser.sliderValue),
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
        builder:
            (_) => SettingsPage(
              initialNewsletter: _currentUser.newsletter,
              initialDarkMode: _currentUser.darkMode,
              initialNotifications: _currentUser.notifications,
              initialOfflineMode: _currentUser.offlineMode,
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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => SummaryPage(data: _currentUser)),
    );
  }

  /// Navigiert zur Work-Portfolio-Seite
  void _navigateToWork() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const WorkPage()),
    );
  }

  /// Navigiert zur About-Seite
  void _navigateToAbout() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AboutPage()),
    );
  }

  /// Erstellt alle Navigation-Buttons
  Widget _buildNavigationButtons() {
    return Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      alignment: WrapAlignment.center,
      children: [
        _buildNavigationButton(
          icon: IconUtils.profile,
          label: 'Profilseite',
          onPressed: _navigateToProfile,
        ),
        _buildNavigationButton(
          icon: Icons.person,
          label: 'Über mich',
          onPressed: _navigateToAbout,
        ),
        _buildNavigationButton(
          icon: IconUtils.slider,
          label: 'Slider-Seite',
          onPressed: _navigateToSlider,
        ),
        _buildNavigationButton(
          icon: Icons.work,
          label: 'Meine Arbeiten',
          onPressed: _navigateToWork,
        ),
        _buildNavigationButton(
          icon: IconUtils.settings,
          label: 'Einstellungen',
          onPressed: _navigateToSettings,
        ),
        _buildNavigationButton(
          icon: IconUtils.summary,
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
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildUserAvatar(),
                const SizedBox(height: 24.0),
                _buildWelcomeText(),
                _buildUserInfo(),
                const SizedBox(height: 36.0),
                _buildNavigationButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
