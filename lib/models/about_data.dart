import 'package:flutter/material.dart';

/// Modell-Klasse für About-Seite Daten
///
/// Kapselt alle persönlichen Informationen und strukturiert sie
/// für eine saubere Datenverwendung in der UI.
class AboutData {
  /// Persönliche Grunddaten
  final PersonalInfo personalInfo;

  /// Liste der technischen Fähigkeiten
  final List<SkillCategory> skills;

  /// Bildungsweg und Qualifikationen
  final List<EducationItem> education;

  /// Interessen und Hobbys
  final List<Interest> interests;

  /// Kontaktinformationen
  final List<ContactInfo> contactInfo;

  const AboutData({
    required this.personalInfo,
    required this.skills,
    required this.education,
    required this.interests,
    required this.contactInfo,
  });
}

/// Persönliche Grundinformationen
class PersonalInfo {
  final String name;
  final String title;
  final String shortBio;
  final String detailedBio;
  final List<String> statusTags;

  const PersonalInfo({
    required this.name,
    required this.title,
    required this.shortBio,
    required this.detailedBio,
    required this.statusTags,
  });
}

/// Kategorie für technische Fähigkeiten
class SkillCategory {
  final String title;
  final List<String> skills;
  final SkillLevel level;
  final String? description;

  const SkillCategory({
    required this.title,
    required this.skills,
    required this.level,
    this.description,
  });
}

/// Skill-Level für bessere Kategorisierung
enum SkillLevel { beginner, intermediate, advanced, expert }

/// Bildungs-Eintrag
class EducationItem {
  final String institution;
  final String degree;
  final String period;
  final String description;
  final bool isCompleted;

  const EducationItem({
    required this.institution,
    required this.degree,
    required this.period,
    required this.description,
    this.isCompleted = true,
  });
}

/// Interesse/Hobby-Eintrag
class Interest {
  final IconData icon;
  final String title;
  final String subtitle;
  final String? description;

  const Interest({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.description,
  });
}

/// Kontaktinformation
class ContactInfo {
  final ContactType type;
  final String label;
  final String value;
  final String? url;
  final bool isClickable;

  const ContactInfo({
    required this.type,
    required this.label,
    required this.value,
    this.url,
    this.isClickable = false,
  });
}

/// Typ der Kontaktinformation
enum ContactType {
  email,
  phone,
  website,
  github,
  linkedin,
  university,
  location,
}
