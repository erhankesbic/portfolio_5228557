import 'package:flutter/material.dart';
import 'profile_form_page.dart';
import 'slider_page.dart';
import 'settings_page.dart';
import 'summary_page.dart';
import '../models/user_data.dart';
import '../repositories/user_repository.dart';
import '../constants/app_constants.dart';
import '../theme/app_theme.dart';
import '../widgets/app_widgets.dart';

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
    return AppWidgets.userAvatar();
  }

  /// Erstellt den Willkommens-Text
  Widget _buildWelcomeText() {
    final userName = _currentUser.name;
    final welcomeText =
        userName.isNotEmpty
            ? '${AppConstants.welcomePersonalized}, $userName!'
            : AppConstants.welcomeDefault;

    return Text(
      welcomeText,
      style: AppTheme.headlineSmall,
      textAlign: TextAlign.center,
    );
  }

  /// Erstellt die Benutzerinformationen (E-Mail und Beschreibung)
  Widget _buildUserInfo() {
    return Column(
      children: [
        if (_currentUser.email.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: AppTheme.spacingSmall),
            child: Text(
              _currentUser.email,
              style: AppTheme.titleMedium.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
          ),
        if (_currentUser.about.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: AppTheme.spacingSmall),
            child: Text(
              _currentUser.about,
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.textSecondary,
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
    return AppWidgets.iconButton(
      icon: icon,
      label: label,
      onPressed: onPressed,
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

  /// Erstellt alle Navigation-Buttons
  Widget _buildNavigationButtons() {
    return Wrap(
      spacing: AppTheme.spacingMedium,
      runSpacing: AppTheme.spacingMedium,
      alignment: WrapAlignment.center,
      children: [
        _buildNavigationButton(
          icon: Icons.edit,
          label: AppConstants.profilePageLabel,
          onPressed: _navigateToProfile,
        ),
        _buildNavigationButton(
          icon: Icons.tune,
          label: AppConstants.sliderPageLabel,
          onPressed: _navigateToSlider,
        ),
        _buildNavigationButton(
          icon: Icons.settings,
          label: AppConstants.settingsPageLabel,
          onPressed: _navigateToSettings,
        ),
        _buildNavigationButton(
          icon: Icons.summarize,
          label: AppConstants.summaryPageLabel,
          onPressed: _navigateToSummary,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppConstants.appTitle)),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppTheme.spacingXLarge),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildUserAvatar(),
                AppWidgets.spacing(height: AppTheme.spacingLarge),
                _buildWelcomeText(),
                _buildUserInfo(),
                AppWidgets.spacing(height: AppTheme.spacingXXLarge),
                _buildNavigationButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
