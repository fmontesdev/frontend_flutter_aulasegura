import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_flutter_aulasegura/features/schedules/data/datasources/weekly_schedule_remote_datasource.dart';
import 'package:frontend_flutter_aulasegura/features/schedules/data/repositories/weekly_schedule_repository_impl.dart';
import 'package:frontend_flutter_aulasegura/features/schedules/domain/repositories/weekly_schedule_repository.dart';
import 'package:frontend_flutter_aulasegura/features/schedules/domain/usecases/weekly_schedule_usecases.dart';
import 'package:frontend_flutter_aulasegura/features/access/domain/entities/permission.dart';
import 'package:frontend_flutter_aulasegura/features/auth/presentation/providers/auth_providers.dart';

// DataSource con seed (fake_data)
final wScheduleRemoteDSProvider = Provider<WeeklyScheduleRemoteDataSource>((ref) {
  return WeeklyScheduleRemoteDataSource();
});

// Repositorio
final wScheduleRepositoryProvider = Provider<WeeklyScheduleRepository>((ref) {
  final ds = ref.watch(wScheduleRemoteDSProvider);
  return WeeklyScheduleRepositoryImpl(remoteDataSource: ds);
});

// Casos de uso
final wScheduleUseCasesProvider = Provider<WeeklyScheduleUseCases>((ref) {
  final repo = ref.watch(wScheduleRepositoryProvider);
  return WeeklyScheduleUseCases(repo);
});

// Notifier para manejar el estado de autenticación
class WeeklyScheduleNotifier extends AsyncNotifier<List<Permission>> {
  @override
  Future<List<Permission>> build() async {
    final wScheduleUseCases = ref.watch(wScheduleUseCasesProvider);
    // Obtiene el usuario autenticado
    final user = await ref.watch(authProvider.future);
    if (user == null) {
      // Sin sesión, no hay horarios
      return <Permission>[];
    }
    // Carga inicial de horarios semanales del usuario autenticado
    return wScheduleUseCases.getMyWeeklySchedules();
  }
}

final weeklyScheduleProvider = AsyncNotifierProvider<WeeklyScheduleNotifier, List<Permission>>(() {
  return WeeklyScheduleNotifier();
});
