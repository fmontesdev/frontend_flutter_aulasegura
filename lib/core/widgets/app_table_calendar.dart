import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

class AppTableCalendar extends StatefulWidget {
  final ValueChanged<DateTime> onDaySelected;

  const AppTableCalendar({
    super.key,
    required this.onDaySelected
  });

  @override
  State<AppTableCalendar> createState() => _AppTableCalendarState();
}

class _AppTableCalendarState extends State<AppTableCalendar> {
  final CalendarFormat _format = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('es_ES');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      shadowColor: scheme.onPrimaryContainer.withValues(alpha: 0.6),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(6, 0, 8, 0),
        child: TableCalendar(
          locale: 'es_ES',
          firstDay: DateTime.utc(2025, 9, 1),
          lastDay: DateTime.utc(2026, 7, 31),
          focusedDay: _focusedDay,
          startingDayOfWeek: StartingDayOfWeek.monday,
          calendarFormat: _format,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
            widget.onDaySelected(selectedDay);
          },
          onPageChanged: (focusedDay) => _focusedDay = focusedDay,
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
          ),
          calendarStyle: CalendarStyle(
            // Día actual
            todayDecoration: BoxDecoration(
              color: scheme.secondary.withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
            todayTextStyle: TextStyle(
              color: scheme.onSecondary,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            // Día seleccionado
            selectedDecoration: BoxDecoration(
              color: scheme.secondary,
              shape: BoxShape.circle,
            ),
            selectedTextStyle: TextStyle(
              color: scheme.onSecondary,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
