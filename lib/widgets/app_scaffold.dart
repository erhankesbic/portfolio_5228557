import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/navigation_service.dart';
import '../theme/app_theme.dart';
import '../viewmodels/home_view_model.dart';
import 'app_widgets.dart';
import 'app_drawer.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final String title;

  const AppScaffold({super.key, required this.body, required this.title});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: isSmallScreen,
        title: isSmallScreen
            ? Text(title)
            : Consumer<HomeViewModel>(
                builder: (context, viewModel, child) => Row(
                  children: [
                    // Left: Logo/Title
                    GestureDetector(
                      onTap: () {
                        // Navigiert zur Startseite (sich selbst)
                        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                      },
                      child: Text(
                        'Mein Portfolio',
                        style: AppTheme.headlineMedium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Middle: Navigation Links - use Expanded to take available space
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center, // Center the links
                        children: [
                          Flexible(
                            child: _buildAppBarNavLink(
                              label: 'Meine Arbeiten',
                              onPressed: () => NavigationService.navigateToWork(context),
                            ),
                          ),
                          Flexible(
                            child: _buildAppBarNavLink(
                              label: 'Über mich',
                              onPressed: () => NavigationService.navigateToAbout(context),
                            ),
                          ),
                          Flexible(
                            child: _buildAppBarNavLink(
                              label: 'Kontakt',
                              onPressed: () => NavigationService.navigateToContact(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
        actions: isSmallScreen
            ? []
            : [
                Consumer<HomeViewModel>(
                  builder: (context, viewModel, child) => _buildSettingsIcon(context, viewModel),
                ),
                Consumer<HomeViewModel>(
                  builder: (context, viewModel, child) => _buildProfileIcon(context, viewModel),
                ),
                AppWidgets.spacing(width: AppTheme.spacingMedium),
              ],
      ),
      drawer: isSmallScreen ? const AppDrawer() : null,
      body: body,
    );
  }

  Widget _buildAppBarNavLink({required String label, required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingMedium),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: AppTheme.bodyLarge.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildSettingsIcon(BuildContext context, HomeViewModel viewModel) {
    return IconButton(
      icon: const Icon(Icons.settings, color: Colors.white, size: 30),
      onPressed: () => NavigationService.navigateToSettings(
        context,
      ),
      tooltip: 'Einstellungen',
    );
  }

  Widget _buildProfileIcon(BuildContext context, HomeViewModel viewModel) {
    return IconButton(
      icon: const Icon(Icons.account_circle, color: Colors.white, size: 30),
      onPressed: () => NavigationService.navigateToSummary(
        context,
      ),
      tooltip: 'Zusammenfassung',
    );
  }
}
