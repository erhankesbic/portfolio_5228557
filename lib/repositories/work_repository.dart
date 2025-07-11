import '../models/work_item.dart';

/// Repository für Portfolio-Arbeiten
///
/// Verwaltet alle Portfolio-Projekte und stellt Daten für die UI bereit.
/// Folgt dem Repository Pattern für saubere Datenkapselung.
class WorkRepository {
  // Singleton Pattern
  static final WorkRepository _instance = WorkRepository._internal();
  factory WorkRepository() => _instance;
  WorkRepository._internal();

  /// Sample Portfolio-Daten für Erhan Kesbic
  List<WorkItem> get portfolioItems => [
    WorkItem(
      title: 'Portfolio Flutter App',
      description:
          'Eine moderne Portfolio-App entwickelt mit Flutter für das Uni-Praktikum.',
      detailedDescription:
          'Diese App demonstriert meine Flutter-Kenntnisse mit sauberer Architektur, '
          'State Management, Navigation und responsivem Design. Implementiert mit Clean Code Prinzipien.',
      technologies: ['Flutter', 'Dart', 'Material Design', 'Git'],
      category: 'Mobile App',
      date: DateTime(2025, 7, 11),
      status: WorkStatus.completed,
      repositoryUrl: 'https://github.com/erhankesbic/portfolio_5228557',
      priority: 1,
    ),

    WorkItem(
      title: 'E-Commerce Web App',
      description:
          'Vollständige E-Commerce-Lösung mit modernem Design und Benutzerfreundlichkeit.',
      detailedDescription:
          'Eine umfassende Online-Shop-Lösung mit Produktkatalog, Warenkorb, '
          'Benutzerverwaltung und Zahlungsintegration. Responsive Design für alle Geräte.',
      technologies: ['React', 'Node.js', 'MongoDB', 'Express', 'Stripe'],
      category: 'Web App',
      date: DateTime(2025, 5, 15),
      status: WorkStatus.completed,
      demoUrl: 'https://demo-shop.example.com',
      priority: 2,
    ),

    WorkItem(
      title: 'Task Management System',
      description:
          'Produktivitäts-App für Projektmanagement und Team-Kollaboration.',
      detailedDescription:
          'Ein intuitives System für Aufgabenverwaltung mit Kanban-Boards, '
          'Zeiterfassung, Team-Features und detaillierter Projektanalyse.',
      technologies: ['Vue.js', 'Laravel', 'MySQL', 'WebSocket'],
      category: 'Web App',
      date: DateTime(2025, 3, 22),
      status: WorkStatus.inProgress,
      repositoryUrl: 'https://github.com/erhankesbic/task-manager',
      priority: 3,
    ),

    WorkItem(
      title: 'Mobile Fitness Tracker',
      description:
          'Cross-platform Fitness-App mit Workout-Tracking und Ernährungsplanung.',
      detailedDescription:
          'Eine umfassende Fitness-App die Workouts trackt, Ernährungspläne erstellt '
          'und Fortschritte visualisiert. Mit Social Features und Trainer-Integration.',
      technologies: ['Flutter', 'Firebase', 'Health APIs', 'Charts'],
      category: 'Mobile App',
      date: DateTime(2024, 12, 10),
      status: WorkStatus.completed,
      demoUrl: 'https://fitness-app.example.com',
      priority: 4,
    ),

    WorkItem(
      title: 'AI Chat Bot',
      description:
          'Intelligenter Chatbot mit NLP für Kundenservice-Automatisierung.',
      detailedDescription:
          'Ein KI-gestützter Chatbot der natürliche Sprache versteht und '
          'kontextuelle Antworten gibt. Integriert in verschiedene Messaging-Plattformen.',
      technologies: ['Python', 'TensorFlow', 'NLP', 'REST API'],
      category: 'AI/ML',
      date: DateTime(2024, 9, 5),
      status: WorkStatus.completed,
      repositoryUrl: 'https://github.com/erhankesbic/ai-chatbot',
      priority: 5,
    ),

    WorkItem(
      title: 'Blockchain Voting System',
      description:
          'Dezentrales Wahlsystem basierend auf Blockchain-Technologie.',
      detailedDescription:
          'Ein sicheres, transparentes Wahlsystem das Blockchain nutzt um '
          'Manipulationen zu verhindern und Vertrauen in demokratische Prozesse zu stärken.',
      technologies: ['Solidity', 'Web3.js', 'Ethereum', 'React'],
      category: 'Blockchain',
      date: DateTime(2024, 6, 18),
      status: WorkStatus.planned,
      priority: 6,
    ),
  ];

  /// Gibt alle Portfolio-Items sortiert nach Priorität zurück
  List<WorkItem> getAllItems() {
    final items = List<WorkItem>.from(portfolioItems);
    items.sort((a, b) => a.priority.compareTo(b.priority));
    return items;
  }

  /// Filtert Items nach Kategorie
  List<WorkItem> getItemsByCategory(String category) {
    return portfolioItems
        .where((item) => item.category.toLowerCase() == category.toLowerCase())
        .toList();
  }

  /// Filtert Items nach Status
  List<WorkItem> getItemsByStatus(WorkStatus status) {
    return portfolioItems.where((item) => item.status == status).toList();
  }

  /// Gibt alle verfügbaren Kategorien zurück
  List<String> getCategories() {
    return portfolioItems.map((item) => item.category).toSet().toList()..sort();
  }

  /// Gibt alle verfügbaren Technologien zurück
  List<String> getAllTechnologies() {
    final allTechs = <String>[];
    for (final item in portfolioItems) {
      allTechs.addAll(item.technologies);
    }
    return allTechs.toSet().toList()..sort();
  }

  /// Sucht Items nach Suchbegriff
  List<WorkItem> searchItems(String query) {
    if (query.isEmpty) return getAllItems();

    final lowerQuery = query.toLowerCase();
    return portfolioItems.where((item) {
      return item.title.toLowerCase().contains(lowerQuery) ||
          item.description.toLowerCase().contains(lowerQuery) ||
          item.technologies.any(
            (tech) => tech.toLowerCase().contains(lowerQuery),
          );
    }).toList();
  }

  /// Zählt Items nach Status
  Map<WorkStatus, int> getItemCountByStatus() {
    final counts = <WorkStatus, int>{};
    for (final status in WorkStatus.values) {
      counts[status] = getItemsByStatus(status).length;
    }
    return counts;
  }
}
