import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_flutter_aulasegura/features/schedules/presentation/providers/weekly_schedule_providers.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_filter_selector.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_list.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_schedule_card.dart';

class SchedulesPage extends ConsumerStatefulWidget {
  const SchedulesPage({super.key});

  @override
  ConsumerState<SchedulesPage> createState() => _SchedulesPageState();
}

class _SchedulesPageState extends ConsumerState<SchedulesPage> {
  // int _selectedTypeIndex = 0;
  int _selectedDayIndex = 0;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final weeklySchedulesAsync = ref.watch(weeklyScheduleProvider);

    return Scaffold(
      backgroundColor: scheme.primaryContainer,
      body: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Filtro de día de la semana
            AppFilterSelector(
              options: const ['Lunes', 'Martes', 'Miérc.', 'Jueves', 'Viernes'],
              selectedIndex: _selectedDayIndex,
              onChanged: (i) => setState(() => _selectedDayIndex = i),
            ),
            const SizedBox(height: 18),

            // Horarios
            Expanded(
              child: weeklySchedulesAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text('Error cargando horarios: $error')),
                data: (weeklySchedules) {
                  return AppList(
                    type: 'schedules',
                    items: weeklySchedules.where((s) => s.dayOfWeek == _selectedDayIndex+1).toList(),
                    itemBuilder: (item) => AppScheduleCard(
                      classroom: '${item.room.name} ${item.room.roomCode}',
                      group: item.room.course?.name ?? 'Sin grupo',
                      timeRange: '${item.startTime} - ${item.endTime}',
                      subject: item.subject?.name ?? 'Sin asignatura',
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}