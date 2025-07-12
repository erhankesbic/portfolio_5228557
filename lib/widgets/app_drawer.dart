import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../services/navigation_service.dart';
import '../viewmodels/home_view_model.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
    final currentUser = viewModel.currentUser;
    final primaryColor = Theme.of(context).primaryColor;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentUser.name.isNotEmpty
                      ? currentUser.name
                      : 'Gast',
                  style: AppTheme.headlineMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  currentUser.email.isNotEmpty
                      ? currentUser.email
                      : 'Keine E-Mail hinterlegt',
                  style: AppTheme.bodyMedium.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            context: context,
            icon: Icons.home,
            title: 'Startseite',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          _buildDrawerItem(
            context: context,
            icon: Icons.work,
            title: 'Meine Arbeiten',
            onTap: () {
              Navigator.pop(context);
              NavigationService.navigateToWork(context);
            },
          ),
          _buildDrawerItem(
            context: context,
            icon: Icons.info_outline,
            title: 'Über mich',
            onTap: () {
              Navigator.pop(context);
              NavigationService.navigateToAbout(context);
            },
          ),
          _buildDrawerItem(
            context: context,
            icon: Icons.contact_mail,
            title: 'Kontakt',
            onTap: () {
              Navigator.pop(context);
              NavigationService.navigateToContact(context);
            },
          ),
          _buildDrawerItem(
            context: context,
            icon: Icons.settings,
            title: 'Einstellungen',
            onTap: () {
              Navigator.pop(context);
              NavigationService.navigateToSettings(context);
            },
          ),
          _buildDrawerItem(
            context: context,
            icon: Icons.account_circle,
            title: 'Profil',
            onTap: () {
              Navigator.pop(context);
              NavigationService.navigateToSummary(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({required BuildContext context, IconData? icon, required String title, VoidCallback? onTap}) {
    final primaryColor = Theme.of(context).primaryColor;
    return ListTile(
      leading: icon != null ? Icon(icon, color: primaryColor) : null,
      title: Text(title, style: AppTheme.bodyLarge),
      onTap: onTap,
    );
  }
}
