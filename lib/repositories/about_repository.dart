import 'package:flutter/material.dart';
import '../models/about_data.dart';

/// Repository für About-Seite Daten
///
/// Verwaltet alle persönlichen Informationen und stellt sie strukturiert
/// für die UI bereit. Folgt dem Repository Pattern.
class AboutRepository {
  // Singleton Pattern
  static final AboutRepository _instance = AboutRepository._internal();
  factory AboutRepository() => _instance;
  AboutRepository._internal();

  /// Gibt alle About-Daten für Erhan Kesbic zurück
  AboutData getAboutData() {
    return AboutData(
      personalInfo: _getPersonalInfo(),
      skills: _getSkills(),
      education: _getEducation(),
      interests: _getInterests(),
      contactInfo: _getContactInfo(),
    );
  }

  /// Persönliche Grundinformationen
  PersonalInfo _getPersonalInfo() {
    return const PersonalInfo(
      name: 'Erhan Kesbic',
      title: 'Flutter Developer & Student',
      shortBio:
          'Leidenschaftlicher Student der Informatik mit Fokus auf Mobile App Development',
      detailedBio:
          'Hallo! Ich bin Erhan Kesbic, ein leidenschaftlicher Student der Informatik '
          'mit Schwerpunkt auf Mobile App Development und moderne Webtechnologien. '
          'Meine Reise in die Programmierung begann vor einigen Jahren, und seitdem '
          'entwickle ich kontinuierlich meine Fähigkeiten in verschiedenen Technologien. '
          'Besonders fasziniert mich Flutter für die plattformübergreifende Mobile-Entwicklung. '
          'Ich glaube an sauberen Code, benutzerfreundliches Design und kontinuierliches '
          'Lernen. Jedes Projekt ist für mich eine Gelegenheit, neue Technologien zu '
          'entdecken und meine Problemlösungsfähigkeiten zu verbessern.',
      statusTags: ['🎓 Student', '💻 Developer', '🚀 Lernend'],
    );
  }

  /// Technische Fähigkeiten nach Kategorien
  List<SkillCategory> _getSkills() {
    return [
      const SkillCategory(
        title: 'Frontend Development',
        skills: [
          'Flutter',
          'Dart',
          'React',
          'JavaScript',
          'HTML/CSS',
          'Material Design',
        ],
        level: SkillLevel.advanced,
        description: 'Spezialisierung auf Mobile App Development mit Flutter',
      ),
      const SkillCategory(
        title: 'Backend & Datenbanken',
        skills: [
          'Node.js',
          'Python',
          'Firebase',
          'MongoDB',
          'SQL',
          'REST APIs',
        ],
        level: SkillLevel.intermediate,
        description: 'Solide Grundlagen in Backend-Entwicklung',
      ),
      const SkillCategory(
        title: 'Tools & Workflow',
        skills: ['Git', 'VS Code', 'Docker', 'Figma', 'Agile', 'Clean Code'],
        level: SkillLevel.advanced,
        description: 'Moderne Entwicklungstools und Methoden',
      ),
      const SkillCategory(
        title: 'Architektur & Patterns',
        skills: [
          'Repository Pattern',
          'MVVM',
          'Clean Architecture',
          'State Management',
        ],
        level: SkillLevel.intermediate,
        description: 'Saubere Code-Architektur und Design Patterns',
      ),
    ];
  }

  /// Bildungsweg
  List<EducationItem> _getEducation() {
    return [
      const EducationItem(
        institution: 'Technische Hochschule Mittelhessen',
        degree: 'Bachelor Informatik',
        period: '2023 - Voraussichtlich 2027',
        description:
            '📚 Schwerpunkt: Software Engineering & Mobile Development\n'
            'Kernmodule: Programmierung, Algorithmen, Datenbanken, Software Engineering',
        isCompleted: false,
      ),
      const EducationItem(
        institution: 'GUI-Programmierung Praktikum',
        degree: 'Flutter Development Projekt',
        period: 'Sommersemester 2025',
        description:
            '🚀 Portfolio-Projekt mit Clean Code Architektur\n'
            'Implementierung einer vollständigen Flutter-App mit professioneller Struktur',
        isCompleted: true,
      ),
    ];
  }

  /// Interessen und Hobbys
  List<Interest> _getInterests() {
    return [
      const Interest(
        icon: Icons.code,
        title: 'Programmierung',
        subtitle: 'Neue Technologien entdecken',
        description: 'Ständige Weiterbildung in neuen Frameworks und Sprachen',
      ),
      const Interest(
        icon: Icons.sports_esports,
        title: 'Gaming',
        subtitle: 'Entspannung & Inspiration',
        description: 'Analyse von Game Design und User Experience',
      ),
      const Interest(
        icon: Icons.school,
        title: 'Lernen',
        subtitle: 'Online Kurse & Tutorials',
        description: 'Kontinuierliche Weiterbildung durch Online-Plattformen',
      ),
      const Interest(
        icon: Icons.rocket_launch,
        title: 'Innovation',
        subtitle: 'Zukunftstechnologien',
        description: 'Interesse an KI, IoT und emerging technologies',
      ),
      const Interest(
        icon: Icons.music_note,
        title: 'Musik',
        subtitle: 'Coding-Soundtrack',
        description: 'Musik als Inspiration beim Programmieren',
      ),
      const Interest(
        icon: Icons.sports_soccer,
        title: 'Sport',
        subtitle: 'Fitness & Teamgeist',
        description: 'Work-Life-Balance durch Sport und Teamaktivitäten',
      ),
    ];
  }

  /// Kontaktinformationen
  List<ContactInfo> _getContactInfo() {
    return [
      const ContactInfo(
        type: ContactType.email,
        label: 'E-Mail',
        value: 'erhan.kesbic@mnd.thm.de',
        url: 'mailto:erhan.kesbic@mnd.thm.de',
        isClickable: true,
      ),
      const ContactInfo(
        type: ContactType.university,
        label: 'Universität',
        value: 'Technische Hochschule Mittelhessen',
        url: 'https://www.thm.de',
        isClickable: true,
      ),
      const ContactInfo(
        type: ContactType.github,
        label: 'GitHub',
        value: 'github.com/erhankesbic',
        url: 'https://github.com/erhankesbic',
        isClickable: true,
      ),
      const ContactInfo(
        type: ContactType.location,
        label: 'Standort',
        value: 'Gießen, Deutschland',
        isClickable: false,
      ),
    ];
  }

  /// Gibt die Skill-Level-Beschreibung zurück
  String getSkillLevelText(SkillLevel level) {
    switch (level) {
      case SkillLevel.beginner:
        return 'Grundlagen';
      case SkillLevel.intermediate:
        return 'Fortgeschritten';
      case SkillLevel.advanced:
        return 'Erfahren';
      case SkillLevel.expert:
        return 'Experte';
    }
  }

  /// Gibt die Farbe für ein Skill-Level zurück
  int getSkillLevelColorValue(SkillLevel level) {
    switch (level) {
      case SkillLevel.beginner:
        return 0xFF9E9E9E; // Grey
      case SkillLevel.intermediate:
        return 0xFFFF9800; // Orange
      case SkillLevel.advanced:
        return 0xFF2196F3; // Blue
      case SkillLevel.expert:
        return 0xFF4CAF50; // Green
    }
  }
}
