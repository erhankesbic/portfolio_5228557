import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_widgets.dart';
import '../models/about_data.dart';
import '../repositories/about_repository.dart';
import '../widgets/app_scaffold.dart';

/// About-Seite mit persönlichen Informationen
///
/// Zeigt eine professionelle Übersicht über Erhan Kesbic mit
/// Biografie, Skills und Interessen.
/// Nutzt Repository Pattern für saubere Datenarchitektur.
class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final AboutRepository _aboutRepository = AboutRepository();
  late final AboutData _aboutData;

  @override
  void initState() {
    super.initState();
    _aboutData = _aboutRepository.getAboutData();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Über mich',
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(context, _aboutData.personalInfo),
            _buildBiographySection(_aboutData.personalInfo),
            _buildSkillsSection(context, _aboutData.skills),
            _buildInterestsSection(context, _aboutData.interests),
            AppWidgets.spacing(height: AppTheme.spacingXLarge),
          ],
        ),
      ),
    );
  }

  /// Erstellt die Hero-Sektion mit Profilbild und grundlegenden Infos
  Widget _buildHeroSection(BuildContext context, PersonalInfo personalInfo) {
    final primaryColor = Theme.of(context).primaryColor;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [primaryColor.withAlpha(25), Colors.white],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingXLarge),
        child: Column(
          children: [
            // Profilbild-Placeholder
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [primaryColor, Theme.of(context).colorScheme.secondary],
                ),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withAlpha(75),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Icon(Icons.person, size: 80, color: Colors.white),
            ),
            AppWidgets.spacing(height: AppTheme.spacingLarge),

            // Name und Titel
            Text(
              personalInfo.name,
              style: AppTheme.headlineLarge.copyWith(
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            AppWidgets.spacing(height: AppTheme.spacingSmall),
            Text(
              personalInfo.title,
              style: AppTheme.titleLarge.copyWith(
                color: Theme.of(context).textTheme.titleLarge?.color?.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
            AppWidgets.spacing(height: AppTheme.spacingMedium),

            // Status Tags
            Wrap(
              spacing: AppTheme.spacingSmall,
              runSpacing: AppTheme.spacingSmall,
              alignment: WrapAlignment.center,
              children:
                  personalInfo.statusTags
                      .map(
                        (tag) => Chip(
                          label: Text(
                            tag,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          backgroundColor: primaryColor,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                      )
                      .toList(),
            ),
            AppWidgets.spacing(height: AppTheme.spacingMedium),

            // Kurze Bio
            AppWidgets.card(context: context,
              padding: const EdgeInsets.all(AppTheme.spacingMedium),
              child: Text(
                personalInfo.shortBio,
                style: AppTheme.bodyLarge.copyWith(
                  fontStyle: FontStyle.italic,
                  color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Erstellt die Biografie-Sektion
  Widget _buildBiographySection(PersonalInfo personalInfo) {
    return Container(
      margin: const EdgeInsets.all(AppTheme.spacingLarge),
      child: _buildSection(
        context: context,
        title: 'Meine Geschichte',
        icon: Icons.menu_book,
        child: Text(
          personalInfo.detailedBio,
          style: AppTheme.bodyMedium.copyWith(
            height: 1.6,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }

  /// Erstellt die Skills-Sektion
  Widget _buildSkillsSection(BuildContext context, List<SkillCategory> skills) {
    return Container(
      margin: const EdgeInsets.all(AppTheme.spacingLarge),
      child: _buildSection(
        context: context,
        title: 'Technische Fähigkeiten',
        icon: Icons.build,
        child: Column(
          children:
              skills
                  .map((skillCategory) => _buildSkillCategory(context, skillCategory))
                  .toList(),
        ),
      ),
    );
  }

  /// Erstellt eine einzelne Skill-Kategorie
  Widget _buildSkillCategory(BuildContext context, SkillCategory skillCategory) {
    final primaryColor = Theme.of(context).primaryColor;
    final skillLevelText = _aboutRepository.getSkillLevelText(
      skillCategory.level,
    );
    final skillLevelColor = Color(
      _aboutRepository.getSkillLevelColorValue(skillCategory.level),
    );

    return AppWidgets.card(context: context,
      margin: const EdgeInsets.only(bottom: AppTheme.spacingLarge),
      padding: const EdgeInsets.all(AppTheme.spacingMedium),
      elevation: 2,
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                skillCategory.title,
                style: AppTheme.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingSmall,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: skillLevelColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  skillLevelText,
                  style: TextStyle(
                    color: skillLevelColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          if (skillCategory.description != null) ...[
            AppWidgets.spacing(height: AppTheme.spacingSmall),
            Text(
              skillCategory.description!,
              style: AppTheme.bodySmall.copyWith(
                color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
          AppWidgets.spacing(height: AppTheme.spacingMedium),
          Wrap(
            spacing: AppTheme.spacingSmall,
            runSpacing: AppTheme.spacingSmall,
            children:
                skillCategory.skills
                    .map(
                      (skill) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.spacingSmall,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(51),
                          borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                        ),
                        child: Text(
                          skill,
                          style: AppTheme.bodySmall.copyWith(
                            color: primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }

  /// Erstellt die Interessen-Sektion
  Widget _buildInterestsSection(BuildContext context, List<Interest> interests) {
    return Container(
      margin: const EdgeInsets.all(AppTheme.spacingLarge),
      child: _buildSection(
        context: context,
        title: 'Interessen & Hobbys',
        icon: Icons.star,
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Mehr Elemente pro Zeile
            childAspectRatio: 1, // Quadratischere Karten
            crossAxisSpacing: AppTheme.spacingMedium,
            mainAxisSpacing: AppTheme.spacingMedium,
          ),
          itemCount: interests.length,
          itemBuilder: (context, index) => _buildInterestCard(context, interests[index]),
        ),
      ),
    );
  }

  /// Erstellt eine einzelne Interesse-Karte
  Widget _buildInterestCard(BuildContext context, Interest interest) {
    final primaryColor = Theme.of(context).primaryColor;
    return AppWidgets.card(context: context,
      padding: const EdgeInsets.all(AppTheme.spacingSmall), // Weniger Padding
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(interest.icon, color: primaryColor, size: 28), // Kleineres Icon
          AppWidgets.spacing(height: AppTheme.spacingXSmall),
          Text(
            interest.title,
            style: AppTheme.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          AppWidgets.spacing(height: 2),
          Text(
            interest.subtitle,
            style: AppTheme.bodySmall.copyWith(color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Hilfsmethode für Sections
  Widget _buildSection({
    required BuildContext context, 
    required String title,
    required Widget child,
    IconData? icon,
  }) {
    final primaryColor = Theme.of(context).primaryColor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: primaryColor, size: 24),
              const SizedBox(width: 8),
            ],
            Text(
              title,
              style: AppTheme.headlineSmall.copyWith(
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ],
        ),
        AppWidgets.spacing(height: AppTheme.spacingLarge),
        child,
      ],
    );
  }
}
