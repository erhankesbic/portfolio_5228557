import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_data.dart';
import '../services/navigation_service.dart';
import '../theme/app_theme.dart';
import '../viewmodels/home_view_model.dart';
import '../widgets/app_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mein Portfolio'),
        elevation: 0,
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
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
                _buildNavigationButtons(context, viewModel),
              ],
            ),
          ),
        ),
      ),
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

  Widget _buildNavigationButtons(BuildContext context, HomeViewModel viewModel) {
    return Wrap(
      spacing: AppTheme.spacingMedium,
      runSpacing: AppTheme.spacingMedium,
      alignment: WrapAlignment.center,
      children: [
        _buildNavigationButton(
          icon: Icons.person,
          label: 'Profilseite',
          onPressed: () => _navigateToProfile(context, viewModel),
        ),
        _buildNavigationButton(
          icon: Icons.info_outline,
          label: 'Über mich',
          onPressed: () => _navigateToAbout(context),
        ),
        _buildNavigationButton(
          icon: Icons.tune,
          label: 'Slider-Seite',
          onPressed: () => _navigateToSlider(context, viewModel),
        ),
        _buildNavigationButton(
          icon: Icons.work,
          label: 'Meine Arbeiten',
          onPressed: () => _navigateToWork(context),
        ),
        _buildNavigationButton(
          icon: Icons.settings,
          label: 'Einstellungen',
          onPressed: () => _navigateToSettings(context, viewModel),
        ),
        _buildNavigationButton(
          icon: Icons.summarize,
          label: 'Zusammenfassung',
          onPressed: () => _navigateToSummary(context, viewModel.currentUser),
        ),
        _buildNavigationButton(
          icon: Icons.contact_mail,
          label: 'Kontakt',
          onPressed: () => _navigateToContact(context),
        ),
      ],
    );
  }

  Widget _buildNavigationButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      icon: Icon(icon, color: AppTheme.primaryColor),
      onPressed: onPressed,
      label: Text(
        label,
        style: AppTheme.bodyMedium.copyWith(color: AppTheme.primaryColor),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(160.0, 48.0),
        backgroundColor: AppTheme.surfaceColor,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: BorderSide(color: AppTheme.primaryColor.withAlpha(50)),
      ),
    );
  }

  Future<void> _navigateToProfile(BuildContext context, HomeViewModel viewModel) async {
    final result = await NavigationService.navigateToProfile(
      context,
      name: viewModel.currentUser.name,
      email: viewModel.currentUser.email,
      about: viewModel.currentUser.about,
    );
    if (result != null) {
      viewModel.updateProfile(
        result['name'] ?? '',
        result['email'] ?? '',
        result['about'] ?? '',
      );
    }
  }

  Future<void> _navigateToSlider(BuildContext context, HomeViewModel viewModel) async {
    final result = await NavigationService.navigateToSlider(
      context,
      currentValue: viewModel.currentUser.sliderValue,
    );
    if (result != null) {
      viewModel.updateSliderValue(result);
    }
  }

  Future<void> _navigateToSettings(BuildContext context, HomeViewModel viewModel) async {
    final result = await NavigationService.navigateToSettings(
      context,
      newsletter: viewModel.currentUser.newsletter,
      darkMode: viewModel.currentUser.darkMode,
      notifications: viewModel.currentUser.notifications,
      offlineMode: viewModel.currentUser.offlineMode,
    );
    if (result != null) {
      viewModel.updateSettings(
        newsletter: result['newsletter'] ?? false,
        darkMode: result['darkMode'] ?? false,
        notifications: result['notifications'] ?? false,
        offlineMode: result['offlineMode'] ?? false,
      );
    }
  }

  void _navigateToSummary(BuildContext context, UserData currentUser) {
    NavigationService.navigateToSummary(context, userData: currentUser);
  }

  void _navigateToWork(BuildContext context) {
    NavigationService.navigateToWork(context);
  }

  void _navigateToAbout(BuildContext context) {
    NavigationService.navigateToAbout(context);
  }

  void _navigateToContact(BuildContext context) {
    NavigationService.navigateToContact(context);
  }
}
