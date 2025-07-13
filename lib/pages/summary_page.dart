import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../widgets/app_widgets.dart';
import '../widgets/app_scaffold.dart';
import '../services/navigation_service.dart';
import '../viewmodels/home_view_model.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        final data = viewModel.currentUser;
        return AppScaffold(
          title: 'Zusammenfassung',
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacingXLarge),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppWidgets.card(context: context,
                      margin: const EdgeInsets.only(bottom: AppTheme.spacingXLarge),
                      child: Padding(
                        padding: const EdgeInsets.all(AppTheme.spacingLarge),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: primaryColor,
                                  size: 28,
                                ),
                                AppWidgets.spacing(width: AppTheme.spacingSmall),
                                Text(
                                  'Profilinformationen',
                                  style: AppTheme.titleLarge.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            AppWidgets.spacing(height: AppTheme.spacingMedium),
                            Text('Name: ${data.name}', style: AppTheme.bodyLarge),
                            Text(
                              'E-Mail: ${data.email}',
                              style: AppTheme.bodyLarge,
                            ),
                            if (data.about.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: AppTheme.spacingSmall,
                                ),
                                child: Text(
                                  'Über mich: ${data.about}',
                                  style: AppTheme.bodySmall.copyWith(
                                    fontStyle: FontStyle.italic,
                                    color: Theme.of(context).textTheme.bodySmall?.color?.withAlpha((255 * 0.7).round()),
                                  ),
                                ),
                              ),
                            AppWidgets.spacing(height: AppTheme.spacingMedium),
                            AppWidgets.textButton(
                              label: 'Profil bearbeiten',
                              onPressed: () {
                                NavigationService.navigateToProfile(
                                  context,
                                  name: data.name,
                                  email: data.email,
                                  about: data.about,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    AppWidgets.card(context: context,
                      margin: const EdgeInsets.only(bottom: AppTheme.spacingXLarge),
                      child: Padding(
                        padding: const EdgeInsets.all(AppTheme.spacingLarge),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.settings,
                                  color: primaryColor,
                                  size: 28,
                                ),
                                AppWidgets.spacing(width: AppTheme.spacingSmall),
                                Text(
                                  'Einstellungen',
                                  style: AppTheme.titleLarge.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            AppWidgets.spacing(height: AppTheme.spacingMedium),
                            Text(
                              'Newsletter: ${data.newsletter ? 'Ja' : 'Nein'}',
                              style: AppTheme.bodyLarge,
                            ),
                            Text(
                              'Dark Mode: ${data.darkMode ? 'Ja' : 'Nein'}',
                              style: AppTheme.bodyLarge,
                            ),
                            Text(
                              'Benachrichtigungen: ${data.notifications ? 'Ja' : 'Nein'}',
                              style: AppTheme.bodyLarge,
                            ),
                            Text(
                              'Offline-Modus: ${data.offlineMode ? 'Ja' : 'Nein'}',
                              style: AppTheme.bodyLarge,
                            ),
                          AppWidgets.spacing(height: AppTheme.spacingMedium),
                          AppWidgets.textButton(
                            label: 'Einstellungen bearbeiten',
                            onPressed: () {
                              NavigationService.navigateToSettings(
                                context,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                AppWidgets.card(context: context,
                  child: Padding(
                    padding: const EdgeInsets.all(AppTheme.spacingLarge),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.tune,
                              color: primaryColor,
                              size: 28,
                            ),
                            AppWidgets.spacing(width: AppTheme.spacingSmall),
                            Text(
                              'Slider-Wert',
                              style: AppTheme.titleLarge.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        AppWidgets.spacing(height: AppTheme.spacingMedium),
                        Text(
                          'Wert: ${data.sliderValue.toInt()}',
                          style: AppTheme.bodyLarge,
                        ),
                        AppWidgets.spacing(height: AppTheme.spacingMedium),
                        AppWidgets.textButton(
                          label: 'Slider bearbeiten',
                          onPressed: () {
                            NavigationService.navigateToSlider(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
      },
    );
  }
}
        