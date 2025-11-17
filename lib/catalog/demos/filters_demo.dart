import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/core/l10n/app_localizations.dart';
import 'package:frontend_flutter_aulasegura/catalog/widgets/showcase_scaffold.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_filter_selector.dart';

class FiltersDemo extends StatefulWidget {
  final bool darkMode;
  final ValueChanged<bool> onToggleDarkMode;

  const FiltersDemo({
    super.key,
    required this.darkMode,
    required this.onToggleDarkMode,
  });

  @override
  State<FiltersDemo> createState() => _FiltersDemoState();
}

class _FiltersDemoState extends State<FiltersDemo> {
  int index1 = 0;
  int index2 = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final text = theme.textTheme;
    final l10n = AppLocalizations.of(context)!;

    return ShowcaseScaffold(
      title: l10n.filters,
      backgroundColor: scheme.primaryContainer,
      darkMode: widget.darkMode,
      onToggleDarkMode: widget.onToggleDarkMode,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(l10n.selectorOf5Filters, style: text.titleSmall),
          const SizedBox(height: 12),
          AppFilterSelector(
            options: const ['Todas', 'Accesos', 'Avisos', 'Alertas', 'Vistas'],
            selectedIndex: index1,
            onChanged: (i) => setState(() => index1 = i),
          ),
          const SizedBox(height: 20),

          Text(l10n.selectorOf2Filters, style: text.titleSmall),
          const SizedBox(height: 12),
          AppFilterSelector(
            options: const ['Horario semanal', 'Reservas de aulas'],
            selectedIndex: index2,
            onChanged: (i) => setState(() => index2 = i),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
