import 'package:flutter/material.dart';
import '../models/work_item.dart';
import '../repositories/work_repository.dart';
import '../theme/app_theme.dart';
import '../widgets/app_widgets.dart';
import '../widgets/app_scaffold.dart';

/// Portfolio-Seite zur Anzeige aller Arbeiten/Projekte
///
/// Zeigt eine professionelle Übersicht über alle Portfolio-Projekte
/// mit Filterung, Suche und detaillierter Projektansicht.
class WorkPage extends StatefulWidget {
  const WorkPage({super.key});

  @override
  State<WorkPage> createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> {
  final WorkRepository _workRepository = WorkRepository();
  final TextEditingController _searchController = TextEditingController();

  List<WorkItem> _filteredItems = [];
  String _selectedCategory = 'Alle';
  WorkStatus? _selectedStatus;

  @override
  void initState() {
    super.initState();
    _filteredItems = _workRepository.getAllItems();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Filtert die Projekte basierend auf Suchbegriff und Kategorie
  void _filterItems() {
    List<WorkItem> items = _workRepository.getAllItems();

    // Nach Kategorie filtern
    if (_selectedCategory != 'Alle') {
      items =
          items.where((item) => item.category == _selectedCategory).toList();
    }

    // Nach Status filtern
    if (_selectedStatus != null) {
      items = items.where((item) => item.status == _selectedStatus).toList();
    }

    // Nach Suchbegriff filtern
    if (_searchController.text.isNotEmpty) {
      final query = _searchController.text.toLowerCase();
      items =
          items.where((item) {
            return item.title.toLowerCase().contains(query) ||
                item.description.toLowerCase().contains(query) ||
                item.technologies.any(
                  (tech) => tech.toLowerCase().contains(query),
                );
          }).toList();
    }

    setState(() {
      _filteredItems = items;
    });
  }

  /// Erstellt die Suchleiste
  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(AppTheme.spacingMedium),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Projekte durchsuchen...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon:
              _searchController.text.isNotEmpty
                  ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      _filterItems();
                    },
                  )
                  : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
          ),
        ),
        onChanged: (_) => _filterItems(),
      ),
    );
  }

  /// Erstellt die Filter-Chips
  Widget _buildFilterChips() {
    final categories = ['Alle', ..._workRepository.getCategories()];

    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: AppTheme.spacingMedium),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == _selectedCategory;

          return Container(
            margin: const EdgeInsets.only(right: AppTheme.spacingSmall),
            child: FilterChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedCategory = category;
                });
                _filterItems();
              },
              backgroundColor: AppTheme.surfaceColor,
              selectedColor: AppTheme.primaryLight,
            ),
          );
        },
      ),
    );
  }

  /// Erstellt eine Projekt-Karte
  Widget _buildProjectCard(WorkItem item) {
    return AppWidgets.card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingMedium,
        vertical: AppTheme.spacingSmall,
      ),
      child: InkWell(
        onTap: () => _showProjectDetails(item),
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Projekt-Header
            _buildProjectHeader(item),

            AppWidgets.spacing(height: AppTheme.spacingMedium),

            // Projekt-Beschreibung
            Text(
              item.description,
              style: AppTheme.bodyMedium,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),

            AppWidgets.spacing(height: AppTheme.spacingMedium),

            // Technologie-Tags
            _buildTechnologyTags(item.technologies),

            AppWidgets.spacing(height: AppTheme.spacingMedium),

            // Projekt-Footer
            _buildProjectFooter(item),
          ],
        ),
      ),
    );
  }

  /// Erstellt den Projekt-Header
  Widget _buildProjectHeader(WorkItem item) {
    return Row(
      children: [
        // Status-Icon
        Container(
          padding: const EdgeInsets.all(AppTheme.spacingSmall),
          decoration: BoxDecoration(
            color: _getStatusColor(item.status),
            borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
          ),
          child: Icon(
            _getStatusIcon(item.status),
            size: AppTheme.iconSmall,
            color: Colors.white,
          ),
        ),

        AppWidgets.spacing(width: AppTheme.spacingMedium),

        // Titel und Kategorie
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: AppTheme.titleLarge,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '${item.category} • ${item.formattedDate}',
                style: AppTheme.bodySmall.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Erstellt die Technologie-Tags
  Widget _buildTechnologyTags(List<String> technologies) {
    return Wrap(
      spacing: AppTheme.spacingSmall,
      runSpacing: AppTheme.spacingSmall,
      children:
          technologies.take(5).map((tech) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacingSmall,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: AppTheme.primaryLight,
                borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
              ),
              child: Text(
                tech,
                style: AppTheme.bodySmall.copyWith(
                  color: AppTheme.primaryDark,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
    );
  }

  /// Erstellt den Projekt-Footer
  Widget _buildProjectFooter(WorkItem item) {
    return Row(
      children: [
        // Status-Text
        Text(
          item.statusText,
          style: AppTheme.bodySmall.copyWith(
            color: _getStatusColor(item.status),
            fontWeight: FontWeight.w500,
          ),
        ),

        const Spacer(),

        // Action-Buttons
        if (item.hasRepository)
          IconButton(
            icon: const Icon(Icons.code),
            onPressed: () => _openUrl(item.repositoryUrl!),
            tooltip: 'Repository ansehen',
          ),

        if (item.hasDemo)
          IconButton(
            icon: const Icon(Icons.launch),
            onPressed: () => _openUrl(item.demoUrl!),
            tooltip: 'Demo ansehen',
          ),
      ],
    );
  }

  /// Zeigt die Projekt-Details in einem Bottom Sheet
  void _showProjectDetails(WorkItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => DraggableScrollableSheet(
            initialChildSize: 0.7,
            maxChildSize: 0.9,
            minChildSize: 0.5,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(AppTheme.radiusXLarge),
                  ),
                ),
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(AppTheme.spacingLarge),
                  children: [
                    // Handle
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),

                    AppWidgets.spacing(height: AppTheme.spacingLarge),

                    // Titel
                    Text(item.title, style: AppTheme.headlineMedium),

                    AppWidgets.spacing(height: AppTheme.spacingSmall),

                    // Kategorie und Datum
                    Text(
                      '${item.category} • ${item.formattedDate}',
                      style: AppTheme.bodyLarge.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),

                    AppWidgets.spacing(height: AppTheme.spacingLarge),

                    // Detaillierte Beschreibung
                    if (item.detailedDescription != null) ...[
                      Text('Projektbeschreibung', style: AppTheme.titleLarge),
                      AppWidgets.spacing(height: AppTheme.spacingMedium),
                      Text(
                        item.detailedDescription!,
                        style: AppTheme.bodyLarge,
                      ),
                      AppWidgets.spacing(height: AppTheme.spacingLarge),
                    ],

                    // Technologien
                    Text('Verwendete Technologien', style: AppTheme.titleLarge),
                    AppWidgets.spacing(height: AppTheme.spacingMedium),
                    _buildTechnologyTags(item.technologies),

                    AppWidgets.spacing(height: AppTheme.spacingLarge),

                    // Action-Buttons
                    Row(
                      children: [
                        if (item.hasRepository)
                          Expanded(
                            child: AppWidgets.iconButton(
                              icon: Icons.code,
                              label: 'Repository',
                              onPressed: () => _openUrl(item.repositoryUrl!),
                            ),
                          ),

                        if (item.hasRepository && item.hasDemo)
                          AppWidgets.spacing(width: AppTheme.spacingMedium),

                        if (item.hasDemo)
                          Expanded(
                            child: AppWidgets.iconButton(
                              icon: Icons.launch,
                              label: 'Demo',
                              onPressed: () => _openUrl(item.demoUrl!),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
    );
  }

  /// Öffnet eine URL (Placeholder-Implementierung)
  void _openUrl(String url) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Link würde geöffnet: $url'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// Gibt die Farbe für einen Status zurück
  Color _getStatusColor(WorkStatus status) {
    switch (status) {
      case WorkStatus.completed:
        return AppTheme.successColor;
      case WorkStatus.inProgress:
        return AppTheme.warningColor;
      case WorkStatus.planned:
        return AppTheme.primaryColor;
      case WorkStatus.archived:
        return AppTheme.textSecondary;
    }
  }

  /// Gibt das Icon für einen Status zurück
  IconData _getStatusIcon(WorkStatus status) {
    switch (status) {
      case WorkStatus.completed:
        return Icons.check_circle;
      case WorkStatus.inProgress:
        return Icons.work;
      case WorkStatus.planned:
        return Icons.schedule;
      case WorkStatus.archived:
        return Icons.archive;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Meine Arbeiten',
      body: Column(
        children: [
          // Suchleiste
          _buildSearchBar(),

          // Filter-Chips
          _buildFilterChips(),

          AppWidgets.spacing(height: AppTheme.spacingMedium),

          // Projekt-Liste
          Expanded(
            child:
                _filteredItems.isEmpty
                    ? AppWidgets.emptyState(
                      icon: Icons.work_off,
                      message: 'Keine Projekte gefunden',
                      action: AppWidgets.textButton(
                        label: 'Filter zurücksetzen',
                        onPressed: () {
                          setState(() {
                            _selectedCategory = 'Alle';
                            _selectedStatus = null;
                            _searchController.clear();
                            _filteredItems = _workRepository.getAllItems();
                          });
                        },
                      ),
                    )
                    : ListView.builder(
                      itemCount: _filteredItems.length,
                      itemBuilder: (context, index) {
                        return _buildProjectCard(_filteredItems[index]);
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
