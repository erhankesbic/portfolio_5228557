
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../widgets/app_widgets.dart';
import '../widgets/app_scaffold.dart';
import '../viewmodels/home_view_model.dart';
import '../viewmodels/theme_view_model.dart'; // Import new ViewModel

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late bool isNewsletterSubscribed;
  late bool isDarkMode;
  late bool isNotificationsEnabled;
  late bool isOfflineMode;
  
  // Slider value will now represent the Hue
  late double _hueValue;

  @override
  void initState() {
    super.initState();
    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    final themeViewModel = Provider.of<ThemeViewModel>(context, listen: false);
    
    isNewsletterSubscribed = homeViewModel.currentUser.newsletter;
    isDarkMode = homeViewModel.currentUser.darkMode; // This could be linked to ThemeMode
    isNotificationsEnabled = homeViewModel.currentUser.notifications;
    isOfflineMode = homeViewModel.currentUser.offlineMode;

    // Initialize slider value from the current theme color
    _hueValue = HSLColor.fromColor(themeViewModel.primaryColor).hue;
  }

  void _saveSettings() {
    // Only save non-theme related settings
    Provider.of<HomeViewModel>(context, listen: false).updateSettings(
      newsletter: isNewsletterSubscribed,
      darkMode: isDarkMode,
      notifications: isNotificationsEnabled,
      offlineMode: isOfflineMode,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // Use Consumer to get the ThemeViewModel and rebuild on changes
    final themeViewModel = Provider.of<ThemeViewModel>(context);
    final currentThemeColor = themeViewModel.primaryColor;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _saveSettings();
        }
      },
      child: AppScaffold(
        title: 'Einstellungen',
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.spacingXLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppWidgets.card(
                    margin: const EdgeInsets.only(
                      bottom: AppTheme.spacingXLarge,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(AppTheme.spacingLarge),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSwitchTile(
                            context: context,
                            icon: Icons.email,
                            title: 'Newsletter abonnieren',
                            value: isNewsletterSubscribed,
                            onChanged: (val) => setState(() => isNewsletterSubscribed = val),
                          ),
                          AppWidgets.spacing(height: AppTheme.spacingMedium),
                          _buildSwitchTile(
                            context: context,
                            icon: Icons.dark_mode,
                            title: 'Dark Mode',
                            value: isDarkMode,
                            onChanged: (val) => setState(() => isDarkMode = val),
                          ),
                          AppWidgets.spacing(height: AppTheme.spacingMedium),
                          _buildSwitchTile(
                            context: context,
                            icon: Icons.notifications,
                            title: 'Benachrichtigungen',
                            value: isNotificationsEnabled,
                            onChanged: (val) => setState(() => isNotificationsEnabled = val),
                          ),
                          AppWidgets.spacing(height: AppTheme.spacingMedium),
                          _buildSwitchTile(
                            context: context,
                            icon: Icons.offline_bolt,
                            title: 'Offline-Modus',
                            value: isOfflineMode,
                            onChanged: (val) => setState(() => isOfflineMode = val),
                          ),
                        ],
                      ),
                    ),
                  ),
                  AppWidgets.card(
                    margin: const EdgeInsets.only(
                      bottom: AppTheme.spacingXLarge,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(AppTheme.spacingLarge),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'App-Farbe anpassen',
                            style: AppTheme.headlineSmall.copyWith(
                              fontWeight: FontWeight.bold,
                              color: currentThemeColor, // Dynamic color
                            ),
                          ),
                          AppWidgets.spacing(height: AppTheme.spacingLarge),
                          // Color Preview
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: currentThemeColor, // Dynamic color
                              borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                              boxShadow: [
                                BoxShadow(
                                  color: currentThemeColor.withAlpha(128),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                          ),
                          AppWidgets.spacing(height: AppTheme.spacingLarge),
                          // Hue Slider
                          Slider(
                            min: 0,
                            max: 360,
                            value: _hueValue,
                            activeColor: currentThemeColor, // Dynamic color
                            inactiveColor: currentThemeColor.withAlpha(77), // Dynamic color
                            onChanged: (value) {
                              setState(() {
                                _hueValue = value;
                                // Create new color from HSL
                                final newColor = HSLColor.fromAHSL(1.0, _hueValue, 0.5, 0.5).toColor();
                                // Update the theme
                                themeViewModel.setPrimaryColor(newColor);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  AppWidgets.textButton(
                    label: 'Speichern',
                    onPressed: _saveSettings,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Hilfsmethode für Switches
  Widget _buildSwitchTile({
    required BuildContext context, // Pass context
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    // Get color from theme
    final primaryColor = Theme.of(context).primaryColor;
    
    return SwitchListTile(
      secondary: Icon(icon, color: primaryColor),
      title: Text(
        title,
        style: AppTheme.bodyLarge.copyWith(color: AppTheme.textPrimary),
      ),
      value: value,
      onChanged: onChanged,
      activeColor: primaryColor,
      contentPadding: EdgeInsets.zero,
    );
  }
}

