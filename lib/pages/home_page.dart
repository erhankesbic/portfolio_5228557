import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_data.dart';
import '../services/navigation_service.dart';
import '../theme/app_theme.dart';
import '../viewmodels/home_view_model.dart';
import '../widgets/app_widgets.dart';
import '../widgets/app_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: isSmallScreen,
        title: isSmallScreen
            ? const Text('Mein Portfolio')
            : Row(
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
        actions: isSmallScreen
            ? []
            : [
                _buildSettingsIcon(context, viewModel),
                _buildProfileIcon(context, viewModel),
                AppWidgets.spacing(width: AppTheme.spacingMedium),
              ],
      ),
      drawer: isSmallScreen ? const AppDrawer() : null,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacingXLarge),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildUserAvatar(),
                AppWidgets.spacing(height: AppTheme.spacingLarge),
                _buildWelcomeText(viewModel.currentUser),
                _buildUserInfo(viewModel.currentUser),
                AppWidgets.spacing(height: AppTheme.spacingXLarge),
              ],
            ),
          ),
        ),
      ),
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
        newsletter: viewModel.currentUser.newsletter,
        darkMode: viewModel.currentUser.darkMode,
        notifications: viewModel.currentUser.notifications,
        offlineMode: viewModel.currentUser.offlineMode,
      ),
      tooltip: 'Einstellungen',
    );
  }

  Widget _buildProfileIcon(BuildContext context, HomeViewModel viewModel) {
    return IconButton(
      icon: const Icon(Icons.account_circle, color: Colors.white, size: 30),
      onPressed: () => NavigationService.navigateToSummary(
        context,
        userData: viewModel.currentUser,
      ),
      tooltip: 'Zusammenfassung',
    );
  }

  Widget _buildUserAvatar() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withAlpha(50),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: const Icon(Icons.person, size: 56, color: Colors.white),
    );
  }

  Widget _buildWelcomeText(UserData currentUser) {
    final userName = currentUser.name;
    final welcomeText =
        userName.isNotEmpty ? 'Willkommen, $userName!' : 'Willkommen im Portfolio';

    return Text(
      welcomeText,
      style: AppTheme.headlineMedium.copyWith(
        fontWeight: FontWeight.bold,
        color: AppTheme.primaryColor,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildUserInfo(UserData currentUser) {
    return Column(
      children: [
        if (currentUser.email.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: AppTheme.spacingSmall),
            child: Text(
              currentUser.email,
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
          ),
        if (currentUser.about.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: AppTheme.spacingSmall),
            child: Text(
              currentUser.about,
              style: AppTheme.bodySmall.copyWith(
                color: AppTheme.textSecondary,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }
}
