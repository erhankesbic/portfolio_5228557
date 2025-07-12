import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../widgets/app_widgets.dart';
import '../widgets/app_scaffold.dart';
import '../viewmodels/home_view_model.dart';

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
  late double _sliderValue;

  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<HomeViewModel>(context, listen: false);
    isNewsletterSubscribed = viewModel.currentUser.newsletter;
    isDarkMode = viewModel.currentUser.darkMode;
    isNotificationsEnabled = viewModel.currentUser.notifications;
    isOfflineMode = viewModel.currentUser.offlineMode;
    _sliderValue = viewModel.currentUser.sliderValue;
  }

  void _saveSettings() {
    Provider.of<HomeViewModel>(context, listen: false).updateSettings(
      newsletter: isNewsletterSubscribed,
      darkMode: isDarkMode,
      notifications: isNotificationsEnabled,
      offlineMode: isOfflineMode,
    );
    Provider.of<HomeViewModel>(context, listen: false).updateSliderValue(_sliderValue);
    Navigator.pop(context);
  }

  Color _calculateColor() {
    return Color.lerp(Colors.blue, Colors.red, _sliderValue / 100)!;
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
                            'Slider-Wert',
                            style: AppTheme.headlineSmall.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                          AppWidgets.spacing(height: AppTheme.spacingLarge),
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: _calculateColor(),
                              borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                              boxShadow: [
                                BoxShadow(
                                  color: _calculateColor().withOpacity(0.5),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                          ),
                          AppWidgets.spacing(height: AppTheme.spacingLarge),
                          Text(
                            'Wert: ${_sliderValue.toInt()}',
                            style: AppTheme.headlineMedium.copyWith(
                              color: AppTheme.primaryColor,
                            ),
                          ),
                          Slider(
                            min: 0,
                            max: 100,
                            divisions: 100,
                            value: _sliderValue,
                            activeColor: _calculateColor(),
                            inactiveColor: _calculateColor().withOpacity(0.3),
                            onChanged: (value) {
                              setState(() {
                                _sliderValue = value.roundToDouble();
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
