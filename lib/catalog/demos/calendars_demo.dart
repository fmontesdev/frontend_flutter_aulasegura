import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/catalog/widgets/showcase_scaffold.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_table_calendar.dart';
import 'package:frontend_flutter_aulasegura/core/l10n/app_localizations.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';

class CalendarsDemo extends StatefulWidget {
  final bool darkMode;
  final ValueChanged<bool> onToggleDarkMode;

  const CalendarsDemo({
    super.key,
    required this.darkMode,
    required this.onToggleDarkMode,
  });

  @override
  State<CalendarsDemo> createState() => _CalendarsDemoState();
}

class _CalendarsDemoState extends State<CalendarsDemo> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final text = theme.textTheme;
    final l10n = AppLocalizations.of(context)!;

    return ShowcaseScaffold(
      title: l10n.calendars,
      backgroundColor: scheme.primaryContainer,
      darkMode: widget.darkMode,
      onToggleDarkMode: widget.onToggleDarkMode,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            /// Título
            Text(l10n.tableCalendar, style: text.titleSmall),
            const SizedBox(height: 2),
            Text(
              l10n.monthlyCalendarWithDaySelection,
              style: text.bodyMedium?.copyWith(color: scheme.grey, fontSize: 13),
            ),
            const SizedBox(height: 14),

            /// Calendario
            AppTableCalendar(
              onDaySelected: (selectedDay) {
                setState(() {
                  selectedDate = selectedDay;
                });
              },
            ),
            const SizedBox(height: 16),

            /// Información de la fecha seleccionada
            if (selectedDate != null)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                decoration: BoxDecoration(
                  color: scheme.tertiary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    Icon(Icons.event, color: scheme.tertiary, size: 36),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.selectedDate,
                          style: text.labelMedium?.copyWith(color: scheme.titles),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                          style: text.titleMedium?.copyWith(
                            color: scheme.tertiary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
