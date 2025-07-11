import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_widgets.dart';
import '../models/about_data.dart';
import '../repositories/about_repository.dart';

/// About-Seite mit persönlichen Informationen
///
/// Zeigt eine professionelle Übersicht über Erhan Kesbic mit
/// Biografie, Skills, Erfahrungen und Kontaktinformationen.
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
    return Scaffold(
      appBar: AppBar(title: const Text('Über mich'), elevation: 0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(_aboutData.personalInfo),
            _buildBiographySection(_aboutData.personalInfo),
            _buildSkillsSection(_aboutData.skills),
            _buildEducationSection(_aboutData.education),
            _buildInterestsSection(_aboutData.interests),
            _buildContactSection(_aboutData.contactInfo),
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
          colors: [AppTheme.primaryColor.withValues(alpha: 0.1), Colors.white],
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
                    color: AppTheme.primaryColor.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Icon(Icons.person, size: 80, color: AppTheme.primaryColor),
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
                    color: Colors.grey.withValues(alpha: 0.2),
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
            color: Colors.grey.withValues(alpha: 0.2),
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
                  color: skillLevelColor.withValues(alpha: 0.1),
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
                            color: AppTheme.primaryColor.withValues(alpha: 0.2),
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

  /// Erstellt die Bildungs-Sektion
  Widget _buildEducationSection(List<EducationItem> education) {
    return Container(
      margin: const EdgeInsets.all(AppTheme.spacingLarge),
      child: _buildSection(
        title: 'Bildungsweg',
        icon: Icons.school,
        child: Column(
          children: education.map((item) => _buildEducationItem(item)).toList(),
        ),
      ),
    );
  }

  /// Erstellt einen einzelnen Bildungs-Eintrag
  Widget _buildEducationItem(EducationItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingMedium),
      padding: const EdgeInsets.all(AppTheme.spacingMedium),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border(
          left: BorderSide(
            width: 4,
            color: item.isCompleted ? Colors.green : AppTheme.secondaryColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  item.degree,
                  style: AppTheme.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
              Text(
                item.isCompleted ? '✅' : '⏰',
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
          AppWidgets.spacing(height: AppTheme.spacingSmall),
          Text(
            item.institution,
            style: AppTheme.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
              color: AppTheme.textPrimary,
            ),
          ),
          AppWidgets.spacing(height: AppTheme.spacingSmall),
          Text(
            item.period,
            style: AppTheme.bodySmall.copyWith(color: AppTheme.textSecondary),
          ),
          AppWidgets.spacing(height: AppTheme.spacingMedium),
          Text(
            item.description,
            style: AppTheme.bodySmall.copyWith(
              height: 1.4,
              color: AppTheme.textSecondary,
            ),
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
            crossAxisCount: 2,
            childAspectRatio: 1.2,
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
      padding: const EdgeInsets.all(AppTheme.spacingMedium),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(interest.icon, color: AppTheme.primaryColor, size: 32),
          AppWidgets.spacing(height: AppTheme.spacingSmall),
          Text(
            interest.title,
            style: AppTheme.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          AppWidgets.spacing(height: 4),
          Text(
            interest.subtitle,
            style: AppTheme.bodySmall.copyWith(color: AppTheme.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Erstellt die Kontakt-Sektion
  Widget _buildContactSection(List<ContactInfo> contactInfo) {
    return Container(
      margin: const EdgeInsets.all(AppTheme.spacingLarge),
      child: _buildSection(
        title: 'Kontakt',
        icon: Icons.contact_phone,
        child: Column(
          children:
              contactInfo.map((contact) => _buildContactItem(contact)).toList(),
        ),
      ),
    );
  }

  /// Erstellt einen einzelnen Kontakt-Eintrag
  Widget _buildContactItem(ContactInfo contact) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingSmall),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(AppTheme.spacingSmall),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            _getContactIcon(contact.type),
            color: AppTheme.primaryColor,
            size: 20,
          ),
        ),
        title: Text(
          contact.label,
          style: AppTheme.bodyMedium.copyWith(
            fontWeight: FontWeight.w500,
            color: AppTheme.textPrimary,
          ),
        ),
        subtitle: Text(
          contact.value,
          style: AppTheme.bodySmall.copyWith(
            color:
                contact.isClickable
                    ? AppTheme.primaryColor
                    : AppTheme.textSecondary,
            decoration: contact.isClickable ? TextDecoration.underline : null,
          ),
        ),
        onTap:
            contact.isClickable
                ? () => _showContactSnackBar(contact.value)
                : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        tileColor:
            contact.isClickable
                ? AppTheme.primaryColor.withValues(alpha: 0.05)
                : Colors.transparent,
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

  /// Gibt das passende Material Icon für den Kontakt-Typ zurück
  IconData _getContactIcon(ContactType type) {
    switch (type) {
      case ContactType.email:
        return Icons.email;
      case ContactType.phone:
        return Icons.phone;
      case ContactType.website:
        return Icons.language;
      case ContactType.github:
        return Icons.code;
      case ContactType.linkedin:
        return Icons.business;
      case ContactType.university:
        return Icons.school;
      case ContactType.location:
        return Icons.location_on;
    }
  }

  /// Zeigt eine Info-SnackBar für Kontakt-Clicks
  void _showContactSnackBar(String contactValue) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Kontakt: $contactValue'),
          backgroundColor: AppTheme.primaryColor,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
