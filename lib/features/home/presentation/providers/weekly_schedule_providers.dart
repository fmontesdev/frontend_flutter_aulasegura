import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_flutter_aulasegura/features/home/data/datasources/weekly_schedule_local_datasource.dart';
import 'package:frontend_flutter_aulasegura/features/home/data/repositories/weekly_schedule_repository_impl.dart';
import 'package:frontend_flutter_aulasegura/features/home/domain/repositories/weekly_schedule_repository.dart';
import 'package:frontend_flutter_aulasegura/features/home/domain/usecases/weekly_schedule_usecases.dart';
import 'package:frontend_flutter_aulasegura/features/home/domain/entities/weekly_schedule.dart';
import 'package:frontend_flutter_aulasegura/fake_data/weekly_schedules_list.dart' as seed_data;

import 'package:frontend_flutter_aulasegura/features/auth/presentation/providers/auth_providers.dart';

// DataSource con seed (fake_data)
final wScheduleLocalDSProvider = Provider<WeeklyScheduleLocalDataSource>((ref) {
  return WeeklyScheduleLocalDataSource(seed: seed_data.weeklySchedules);
});

// Repositorio
final wScheduleRepositoryProvider = Provider<WeeklyScheduleRepository>((ref) {
  final ds = ref.watch(wScheduleLocalDSProvider);
  return WeeklyScheduleRepositoryImpl(localDataSource: ds);
});

// Casos de uso
final wScheduleUseCasesProvider = Provider<WeeklyScheduleUseCases>((ref) {
  final repo = ref.watch(wScheduleRepositoryProvider);
  return WeeklyScheduleUseCases(repo);
});

// Notifier para manejar el estado de autenticación
class WeeklyScheduleNotifier extends AsyncNotifier<List<WeeklySchedule>> {
  late final WeeklyScheduleUseCases wScheduleUseCases;

  @override
  Future<List<WeeklySchedule>> build() async {
    wScheduleUseCases = ref.watch(wScheduleUseCasesProvider);
    // Obtiene el usuario autenticado
    final user = await ref.watch(authProvider.future);
    if (user == null) {
      // Sin sesión → no hay horarios
      return <WeeklySchedule>[];
    }
    // Carga inicial de horarios semanales del usuario autenticado
    return wScheduleUseCases.getWeeklySchedulesByUserId(user.id);
  }
}

final weeklyScheduleProvider = AsyncNotifierProvider<WeeklyScheduleNotifier, List<WeeklySchedule>>(() {
  return WeeklyScheduleNotifier();
});
