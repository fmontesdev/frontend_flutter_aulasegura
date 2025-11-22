import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_flutter_aulasegura/features/schedules/presentation/providers/weekly_schedule_providers.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_filter_selector.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_list.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_schedule_card.dart';
import 'package:frontend_flutter_aulasegura/core/l10n/app_localizations.dart';

class SchedulesPage extends ConsumerStatefulWidget {
  const SchedulesPage({super.key});

  @override
  ConsumerState<SchedulesPage> createState() => _SchedulesPageState();
}

class _SchedulesPageState extends ConsumerState<SchedulesPage> {
  int _selectedDayIndex = 0;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final weeklySchedulesAsync = ref.watch(weeklyScheduleProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: scheme.primaryContainer,
      body: Padding(
        padding: const EdgeInsets.only(top: 18, left: 18, right: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// Filtro de día de la semana
            AppFilterSelector(
              options: [
                l10n.dayOfWeek('monday'),
                l10n.dayOfWeek('tuesday'),
                l10n.dayOfWeek('wednesday'),
                l10n.dayOfWeek('thursday'),
                l10n.dayOfWeek('friday')
              ],
              selectedIndex: _selectedDayIndex,
              onChanged: (i) => setState(() => _selectedDayIndex = i),
            ),
            const SizedBox(height: 18),

            /// Horarios
            Expanded(
              child: weeklySchedulesAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text(l10n.loadingSchedulesError(error.toString()))), //? Mensaje de error cargando horarios con internacionalización
                data: (weeklySchedules) {
                  return AppList(
                    type: 'schedules',
                    items: weeklySchedules.where((s) => s.dayOfWeek == _selectedDayIndex+1).toList(),
                    itemBuilder: (item) => AppScheduleCard(
                      classroom: '${item.room!.name} ${item.room!.roomCode}',
                      group: item.room!.courseName ?? 'Sin grupo',
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