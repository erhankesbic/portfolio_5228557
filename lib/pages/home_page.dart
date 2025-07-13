import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_data.dart';
import '../theme/app_theme.dart';
import '../viewmodels/home_view_model.dart';
import '../widgets/app_widgets.dart';
import '../widgets/app_scaffold.dart';
import 'about_page.dart';
import 'work_page.dart';
import 'contact_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);

    return AppScaffold(
      title: 'Mein Portfolio',
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingXLarge),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildUserAvatar(context),
              AppWidgets.spacing(height: AppTheme.spacingLarge),
              _buildWelcomeText(context, viewModel.currentUser),
              _buildUserInfo(context, viewModel.currentUser),
              AppWidgets.spacing(height: AppTheme.spacingXLarge),
              _buildIntroductionSection(context),
              AppWidgets.spacing(height: AppTheme.spacingXLarge),
              _buildServicesSection(context),
              AppWidgets.spacing(height: AppTheme.spacingXLarge),
              _buildLatestProjectsSection(context),
              AppWidgets.spacing(height: AppTheme.spacingXLarge),
              _buildCallToActionsSection(context),
              AppWidgets.spacing(height: AppTheme.spacingXLarge),
            ],
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
    final userName =
        currentUser.name.isNotEmpty ? currentUser.name : 'Besucher';
    final welcomeText =
        'Willkommen, $userName!';

    return Text(
      welcomeText,
      style: AppTheme.headlineMedium.copyWith(
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildUserInfo(BuildContext context, UserData currentUser) {
    return Column(
      children: [
        if (currentUser.email.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: AppTheme.spacingSmall),
            child: Text(
              currentUser.email,
              style: AppTheme.bodyMedium.copyWith(
                color: Theme.of(context).textTheme.bodyMedium?.color?.withAlpha((255 * 0.7).round()),
              ),
            ),
          ),
        if (currentUser.about.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: AppTheme.spacingSmall),
            child: Text(
              currentUser.about,
              style: AppTheme.bodySmall.copyWith(
                color: Theme.of(context).textTheme.bodySmall?.color?.withAlpha((255 * 0.7).round()),
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }

  Widget _buildIntroductionSection(BuildContext context) {
    return Column(
      children: [
        Text(
          'Kreativität trifft auf Funktionalität',
          style: AppTheme.headlineSmall.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        AppWidgets.spacing(height: AppTheme.spacingMedium),
        Text(
          'Willkommen in meinem digitalen Raum! Hier entdecken Sie eine Auswahl meiner Arbeiten und erfahren mehr über meine Fähigkeiten und Leidenschaften.',
          style: AppTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildServicesSection(BuildContext context) {
    return Column(
      children: [
        Text(
          'Meine Dienstleistungen',
          style: AppTheme.headlineSmall.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        AppWidgets.spacing(height: AppTheme.spacingLarge),
        Wrap(
          spacing: AppTheme.spacingMedium,
          runSpacing: AppTheme.spacingMedium,
          alignment: WrapAlignment.center,
          children: [
            _buildServiceCard(context, Icons.design_services, 'UI/UX Design', 'Intuitive und ansprechende Benutzeroberflächen.'),
            _buildServiceCard(context, Icons.developer_mode, 'App Entwicklung', 'Robuste und skalierbare mobile Anwendungen.'),
            _buildServiceCard(context, Icons.code, 'Web Entwicklung', 'Moderne und responsive Webseiten.'),
          ],
        ),
      ],
    );
  }

  Widget _buildServiceCard(BuildContext context, IconData icon, String title, String description) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.radiusMedium)),
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(AppTheme.spacingMedium),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Theme.of(context).primaryColor),
            AppWidgets.spacing(height: AppTheme.spacingSmall),
            Text(
              title,
              style: AppTheme.titleMedium.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            AppWidgets.spacing(height: AppTheme.spacingXSmall),
            Text(
              description,
              style: AppTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLatestProjectsSection(BuildContext context) {
    return Column(
      children: [
        Text(
          'Neueste Projekte',
          style: AppTheme.headlineSmall.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        AppWidgets.spacing(height: AppTheme.spacingLarge),
        SizedBox(
          height: 200, // Fixed height for project cards
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildProjectCard(context, 'Projekt A', 'Eine innovative mobile App.', 'assets/images/project_a.png'),
              _buildProjectCard(context, 'Projekt B', 'Responsive Webanwendung.', 'assets/images/project_b.png'),
              _buildProjectCard(context, 'Projekt C', 'UI/UX Redesign Studie.', 'assets/images/project_c.png'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProjectCard(BuildContext context, String title, String description, String imageUrl) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.radiusMedium)),
      margin: const EdgeInsets.symmetric(horizontal: AppTheme.spacingSmall),
      child: Container(
        width: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(AppTheme.radiusMedium)),
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingSmall),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.titleMedium.copyWith(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  AppWidgets.spacing(height: AppTheme.spacingXSmall),
                  Text(
                    description,
                    style: AppTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCallToActionsSection(BuildContext context) {
    return Column(
      children: [
        Text(
          'Bereit für den nächsten Schritt?',
          style: AppTheme.headlineSmall.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        AppWidgets.spacing(height: AppTheme.spacingLarge),
        Wrap(
          spacing: AppTheme.spacingMedium,
          runSpacing: AppTheme.spacingMedium,
          alignment: WrapAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutPage()));
              },
              icon: const Icon(Icons.info_outline),
              label: const Text('Mehr über mich'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const WorkPage()));
              },
              icon: const Icon(Icons.work_outline),
              label: const Text('Meine Projekte ansehen'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactPage()));
              },
              icon: const Icon(Icons.mail_outline),
              label: const Text('Kontakt aufnehmen'),
            ),
          ],
        ),
      ],
    );
  }
}

