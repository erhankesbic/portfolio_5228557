import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_data.dart';
import '../theme/app_theme.dart';
import '../viewmodels/home_view_model.dart';
import '../widgets/app_widgets.dart';
import '../widgets/app_scaffold.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);

    return AppScaffold(
      title: 'Mein Portfolio',
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacingXLarge),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildUserAvatar(context),
                AppWidgets.spacing(height: AppTheme.spacingLarge),
                _buildWelcomeText(context, viewModel.currentUser),
                _buildUserInfo(viewModel.currentUser),
                AppWidgets.spacing(height: AppTheme.spacingXLarge),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserAvatar(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [primaryColor, Theme.of(context).colorScheme.secondary],
        ),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withAlpha(50),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: const Icon(Icons.person, size: 56, color: Colors.white),
    );
  }

  Widget _buildWelcomeText(BuildContext context, UserData currentUser) {
    final primaryColor = Theme.of(context).primaryColor;
    final userName = currentUser.name;
    final welcomeText =
        userName.isNotEmpty ? 'Willkommen, $userName!' : 'Willkommen im Portfolio';

    return Text(
      welcomeText,
      style: AppTheme.headlineMedium.copyWith(
        fontWeight: FontWeight.bold,
        color: primaryColor,
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

