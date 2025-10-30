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

  bool _isWeekend(DateTime day) {
    // 6 = sábado, 7 = domingo
    return day.weekday == DateTime.saturday || day.weekday == DateTime.sunday;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final locale = Localizations.localeOf(context).toString(); // 'es', 'ca', 'en'

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      shadowColor: scheme.onPrimaryContainer.withValues(alpha: 0.6),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(9, 0, 12, 8),
        child: TableCalendar(
          locale: locale,
          firstDay: DateTime.now(),
          lastDay: DateTime.utc(2026, 7, 31),
          focusedDay: _focusedDay,
          startingDayOfWeek: StartingDayOfWeek.monday,
          calendarFormat: _format,
          daysOfWeekHeight: 40, // Altura de la fila de los dias de la semana
          rowHeight: 48, // Altura de las filas de los dias (por defecto 52)
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          enabledDayPredicate: (day) => !_isWeekend(day), // Deshabilita fines de semana
          onDaySelected: (selectedDay, focusedDay) {
            if (!_isWeekend(selectedDay)) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            }
            widget.onDaySelected(selectedDay);
          },
          onPageChanged: (focusedDay) => _focusedDay = focusedDay,
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            titleTextStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          calendarStyle: CalendarStyle(
            // Define el tamaño de las celdas (más espacio para los círculos)
            cellMargin: const EdgeInsets.all(3),
            cellPadding: const EdgeInsets.all(3),
            // Día actual
            todayDecoration: BoxDecoration(
              color: scheme.tertiary.withValues(alpha: 0.55),
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
          calendarBuilders: CalendarBuilders(
            disabledBuilder: (context, day, focusedDay) {
              // Personaliza el aspecto de días deshabilitados
              return Center(
                child: Text(
                  '${day.day}',
                  style: TextStyle(
                    color: _isWeekend(day) 
                      ? scheme.error.withValues(alpha: 0.6)
                      : scheme.onSurface.withValues(alpha: 0.35),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}