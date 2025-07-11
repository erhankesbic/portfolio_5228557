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
            _buildHeroSection(_aboutData.personalInfo),
            _buildBiographySection(_aboutData.personalInfo),
            _buildSkillsSection(_aboutData.skills),
            _buildInterestsSection(_aboutData.interests),
            AppWidgets.spacing(height: AppTheme.spacingXLarge),
          ],
        ),
      ),
    );
  }

  /// Erstellt die Hero-Sektion mit Profilbild und grundlegenden Infos
  Widget _buildHeroSection(PersonalInfo personalInfo) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppTheme.primaryColor.withAlpha(25), Colors.white],
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
                  colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryColor.withAlpha(75),
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
                color: AppTheme.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            AppWidgets.spacing(height: AppTheme.spacingSmall),
            Text(
              personalInfo.title,
              style: AppTheme.titleLarge.copyWith(
                color: AppTheme.textSecondary,
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
                          backgroundColor: AppTheme.primaryColor,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                      )
                      .toList(),
            ),
            AppWidgets.spacing(height: AppTheme.spacingMedium),

            // Kurze Bio
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingMedium),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withAlpha(50),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                personalInfo.shortBio,
                style: AppTheme.bodyLarge.copyWith(
                  fontStyle: FontStyle.italic,
                  color: AppTheme.textSecondary,
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
        title: 'Meine Geschichte',
        icon: Icons.menu_book,
        child: Text(
          personalInfo.detailedBio,
          style: AppTheme.bodyMedium.copyWith(
            height: 1.6,
            color: AppTheme.textPrimary,
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }

  /// Erstellt die Skills-Sektion
  Widget _buildSkillsSection(List<SkillCategory> skills) {
    return Container(
      margin: const EdgeInsets.all(AppTheme.spacingLarge),
      child: _buildSection(
        title: 'Technische Fähigkeiten',
        icon: Icons.build,
        child: Column(
          children:
              skills
                  .map((skillCategory) => _buildSkillCategory(skillCategory))
                  .toList(),
        ),
      ),
    );
  }

  /// Erstellt eine einzelne Skill-Kategorie
  Widget _buildSkillCategory(SkillCategory skillCategory) {
    final skillLevelText = _aboutRepository.getSkillLevelText(
      skillCategory.level,
    );
    final skillLevelColor = Color(
      _aboutRepository.getSkillLevelColorValue(skillCategory.level),
    );

    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingLarge),
      padding: const EdgeInsets.all(AppTheme.spacingMedium),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(50),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border(left: BorderSide(width: 4, color: skillLevelColor)),
      ),
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
                  color: AppTheme.primaryColor,
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
                color: AppTheme.textSecondary,
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
                          color: AppTheme.surfaceColor,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: AppTheme.primaryColor.withAlpha(50),
                          ),
                        ),
                        child: Text(
                          skill,
                          style: const TextStyle(
                            fontSize: 12,
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
  Widget _buildInterestsSection(List<Interest> interests) {
    return Container(
      margin: const EdgeInsets.all(AppTheme.spacingLarge),
      child: _buildSection(
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
          itemBuilder: (context, index) => _buildInterestCard(interests[index]),
        ),
      ),
    );
  }

  /// Erstellt eine einzelne Interesse-Karte
  Widget _buildInterestCard(Interest interest) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingSmall), // Weniger Padding
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(50),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(interest.icon, color: AppTheme.primaryColor, size: 28), // Kleineres Icon
          AppWidgets.spacing(height: AppTheme.spacingXSmall),
          Text(
            interest.title,
            style: AppTheme.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          AppWidgets.spacing(height: 2),
          Text(
            interest.subtitle,
            style: AppTheme.bodySmall.copyWith(color: AppTheme.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Hilfsmethode für Sections
  Widget _buildSection({
    required String title,
    required Widget child,
    IconData? icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: AppTheme.primaryColor, size: 24),
              const SizedBox(width: 8),
            ],
            Text(
              title,
              style: AppTheme.headlineSmall.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
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
