import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/catalog/widgets/showcase_scaffold.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_slider_selector.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_selectable_pill.dart';
import 'package:frontend_flutter_aulasegura/core/l10n/app_localizations.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';

class SelectorsDemo extends StatefulWidget {
  final bool darkMode;
  final ValueChanged<bool> onToggleDarkMode;

  const SelectorsDemo({
    super.key,
    required this.darkMode,
    required this.onToggleDarkMode,
  });

  @override
  State<SelectorsDemo> createState() => _SelectorsDemoState();
}

class _SelectorsDemoState extends State<SelectorsDemo> {
  List<int> selectedSingle = [];
  List<int> selectedMulti = [];
  List<int> selectedRange = [];

  final rooms = ['Aula 101', 'Aula 102', 'Aula 103', 'Aula 104', 'Aula 105', 'Aula 106'];
  final categories = ['Diseño', 'Desarrollo', 'Marketing', 'Ventas', 'Soporte', 'Operaciones', 'Finanzas'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final text = theme.textTheme;
    final l10n = AppLocalizations.of(context)!;

    return ShowcaseScaffold(
      title: l10n.selectors,
      backgroundColor: scheme.primaryContainer,
      darkMode: widget.darkMode,
      onToggleDarkMode: widget.onToggleDarkMode,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            /// Selector Simple (Single)
            Text(l10n.simpleSelector, style: text.titleSmall),
            const SizedBox(height: 2),
            Text(
              l10n.singleElementSelection,
              style: text.bodyMedium?.copyWith(color: scheme.grey, fontSize: 13),
            ),
            const SizedBox(height: 8),
            AppSliderSelector<String>(
              items: rooms,
              selectionMode: SelectionMode.single,
              height: 52,
              spacing: 9,
              itemBuilder: (context, label, isSelected, onTap) {
                return AppSelectablePill(
                  variant: AppPillSelectableVariant.secondary,
                  size: AppPillSelectableSize.md,
                  label: label,
                  isSelected: isSelected,
                  onTap: onTap,
                );
              },
              onSelectionChanged: (selection) {
                setState(() => selectedSingle = selection);
              },
            ),
            const SizedBox(height: 6),
            if (selectedSingle.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  '${l10n.selected}: ${rooms[selectedSingle.first]}',
                  style: text.bodySmall?.copyWith(color: scheme.tertiary),
                ),
              ),
            const SizedBox(height: 8),

            /// Selector Múltiple (Multi)
            Text(l10n.multipleSelector, style: text.titleSmall),
            const SizedBox(height: 2),
            Text(
              l10n.multipleElementSelection,
              style: text.bodyMedium?.copyWith(color: scheme.grey, fontSize: 13),
            ),
            const SizedBox(height: 10),
            AppSliderSelector<String>(
              items: categories,
              selectionMode: SelectionMode.multi,
              height: 54,
              spacing: 9,
              itemBuilder: (context, label, isSelected, onTap) {
                return AppSelectablePill(
                  variant: AppPillSelectableVariant.tertiary,
                  size: AppPillSelectableSize.lg,
                  label: label,
                  isSelected: isSelected,
                  onTap: onTap,
                );
              },
              onSelectionChanged: (selection) {
                setState(() => selectedMulti = selection);
              },
            ),
            const SizedBox(height: 6),
            if (selectedMulti.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  '${l10n.selectedPlural}: ${selectedMulti.map((i) => categories[i]).join(', ')}',
                  style: text.bodySmall?.copyWith(color: scheme.tertiary),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
