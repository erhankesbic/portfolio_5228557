/// Modell-Klasse für Portfolio-Arbeiten
///
/// Enthält alle relevanten Informationen für ein Portfolio-Projekt:
/// - Grundinformationen (Titel, Beschreibung, Technologien)
/// - Projektdetails (Datum, Status, Repository)
/// - Visuelle Elemente (Bilder, Icons)
class WorkItem {
  /// Titel des Projekts
  final String title;

  /// Kurze Beschreibung des Projekts
  final String description;

  /// Ausführliche Beschreibung des Projekts
  final String? detailedDescription;

  /// Liste der verwendeten Technologien
  final List<String> technologies;

  /// Projekt-Kategorie (z.B. "Mobile App", "Web App", "Game")
  final String category;

  /// Projektdatum
  final DateTime date;

  /// Projekt-Status
  final WorkStatus status;

  /// GitHub Repository URL (optional)
  final String? repositoryUrl;

  /// Live Demo URL (optional)
  final String? demoUrl;

  /// Lokaler Bildpfad (optional)
  final String? imagePath;

  /// Asset-Bildpfad (optional)
  final String? imageAsset;

  /// Icon für das Projekt
  final String? iconPath;

  /// Projekt-Priorität für Sortierung
  final int priority;

  /// Erstellt eine neue WorkItem-Instanz
  const WorkItem({
    required this.title,
    required this.description,
    required this.technologies,
    required this.category,
    required this.date,
    this.detailedDescription,
    this.status = WorkStatus.completed,
    this.repositoryUrl,
    this.demoUrl,
    this.imagePath,
    this.imageAsset,
    this.iconPath,
    this.priority = 0,
  });

  /// Erstellt eine Kopie mit geänderten Werten
  WorkItem copyWith({
    String? title,
    String? description,
    String? detailedDescription,
    List<String>? technologies,
    String? category,
    DateTime? date,
    WorkStatus? status,
    String? repositoryUrl,
    String? demoUrl,
    String? imagePath,
    String? imageAsset,
    String? iconPath,
    int? priority,
  }) {
    return WorkItem(
      title: title ?? this.title,
      description: description ?? this.description,
      detailedDescription: detailedDescription ?? this.detailedDescription,
      technologies: technologies ?? this.technologies,
      category: category ?? this.category,
      date: date ?? this.date,
      status: status ?? this.status,
      repositoryUrl: repositoryUrl ?? this.repositoryUrl,
      demoUrl: demoUrl ?? this.demoUrl,
      imagePath: imagePath ?? this.imagePath,
      imageAsset: imageAsset ?? this.imageAsset,
      iconPath: iconPath ?? this.iconPath,
      priority: priority ?? this.priority,
    );
  }

  /// Prüft ob das Projekt ein Repository hat
  bool get hasRepository => repositoryUrl != null && repositoryUrl!.isNotEmpty;

  /// Prüft ob das Projekt eine Demo hat
  bool get hasDemo => demoUrl != null && demoUrl!.isNotEmpty;

  /// Prüft ob das Projekt ein Bild hat
  bool get hasImage =>
      (imagePath != null && imagePath!.isNotEmpty) ||
      (imageAsset != null && imageAsset!.isNotEmpty);

  /// Formatiertes Datum als String
  String get formattedDate {
    return '${date.day}.${date.month}.${date.year}';
  }

  /// Status-Text für die UI
  String get statusText {
    switch (status) {
      case WorkStatus.completed:
        return 'Abgeschlossen';
      case WorkStatus.inProgress:
        return 'In Arbeit';
      case WorkStatus.planned:
        return 'Geplant';
      case WorkStatus.archived:
        return 'Archiviert';
    }
  }

  @override
  String toString() {
    return 'WorkItem(title: $title, category: $category, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WorkItem &&
        other.title == title &&
        other.category == category &&
        other.date == date;
  }

  @override
  int get hashCode => title.hashCode ^ category.hashCode ^ date.hashCode;
}

/// Enum für den Projekt-Status
enum WorkStatus { completed, inProgress, planned, archived }
