import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_widgets.dart';

class SettingsPage extends StatefulWidget {
  final bool initialNewsletter;
  final bool initialDarkMode;
  final bool initialNotifications;
  final bool initialOfflineMode;

  const SettingsPage({
    super.key,
    required this.initialNewsletter,
    required this.initialDarkMode,
    required this.initialNotifications,
    required this.initialOfflineMode,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late bool isNewsletterSubscribed;
  late bool isDarkMode;
  late bool isNotificationsEnabled;
  late bool isOfflineMode;

  @override
  void initState() {
    super.initState();
    isNewsletterSubscribed = widget.initialNewsletter;
    isDarkMode = widget.initialDarkMode;
    isNotificationsEnabled = widget.initialNotifications;
    isOfflineMode = widget.initialOfflineMode;
  }

  void _saveSettings() {
    Navigator.pop(context, {
      'newsletter': isNewsletterSubscribed,
      'darkMode': isDarkMode,
      'notifications': isNotificationsEnabled,
      'offlineMode': isOfflineMode,
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _saveSettings();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Einstellungen'),
          elevation: 0,
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: Colors.white,
          actions: [
            IconButton(icon: const Icon(Icons.check), onPressed: _saveSettings),
          ],
        ),
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
                            icon: Icons.email,
                            title: 'Newsletter abonnieren',
                            value: isNewsletterSubscribed,
                            onChanged:
                                (val) => setState(
                                  () => isNewsletterSubscribed = val,
                                ),
                          ),
                          AppWidgets.spacing(height: AppTheme.spacingMedium),
                          _buildSwitchTile(
                            icon: Icons.dark_mode,
                            title: 'Dark Mode',
                            value: isDarkMode,
                            onChanged:
                                (val) => setState(() => isDarkMode = val),
                          ),
                          AppWidgets.spacing(height: AppTheme.spacingMedium),
                          _buildSwitchTile(
                            icon: Icons.notifications,
                            title: 'Benachrichtigungen',
                            value: isNotificationsEnabled,
                            onChanged:
                                (val) => setState(
                                  () => isNotificationsEnabled = val,
                                ),
                          ),
                          AppWidgets.spacing(height: AppTheme.spacingMedium),
                          _buildSwitchTile(
                            icon: Icons.offline_bolt,
                            title: 'Offline-Modus',
                            value: isOfflineMode,
                            onChanged:
                                (val) => setState(() => isOfflineMode = val),
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
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      secondary: Icon(icon, color: AppTheme.primaryColor),
      title: Text(
        title,
        style: AppTheme.bodyLarge.copyWith(color: AppTheme.textPrimary),
      ),
      value: value,
      onChanged: onChanged,
      activeColor: AppTheme.primaryColor,
      contentPadding: EdgeInsets.zero,
    );
  }
}
