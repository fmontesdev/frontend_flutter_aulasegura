import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/data/datasources/event_schedule_local_datasource.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/data/repositories/event_schedule_repository_impl.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/domain/repositories/event_schedule_repository.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/domain/usecases/event_schedule_usecases.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/domain/entities/event_schedule.dart';
import 'package:frontend_flutter_aulasegura/fake_data/event_schedules_list.dart' as seed_data;

import 'package:frontend_flutter_aulasegura/features/auth/presentation/providers/auth_providers.dart';

/// DataSource con seed (fake_data)
final eventScheduleLocalDSProvider = Provider<EventScheduleLocalDataSource>((ref) {
  return EventScheduleLocalDataSource(seed: seed_data.eventSchedules);
});

/// Repositorio
final eventScheduleRepositoryProvider = Provider<EventScheduleRepository>((ref) {
  final ds = ref.watch(eventScheduleLocalDSProvider);
  return EventScheduleRepositoryImpl(localDataSource: ds);
});

/// Casos de uso
final eventScheduleUseCasesProvider = Provider<EventScheduleUseCases>((ref) {
  final repo = ref.watch(eventScheduleRepositoryProvider);
  return EventScheduleUseCases(repo);
});

/// Notifier para manejar el estado de las reservas
class EventScheduleNotifier extends AsyncNotifier<List<EventSchedule>> {
  late final EventScheduleUseCases eventScheduleUseCases;

  /// Inicializa el Notifier
  @override
  Future<List<EventSchedule>> build() async {
    eventScheduleUseCases = ref.watch(eventScheduleUseCasesProvider);
    // Obtiene el usuario autenticado
    final user = await ref.watch(authProvider.future);
    if (user == null) {
      // Sin sesión no hay reservas
      return <EventSchedule>[];
    }
    // Carga inicial de reservas del usuario autenticado
    return eventScheduleUseCases.getEventSchedulesByUserId(user.id);
  }

  /// Elimina una reserva por su ID
  Future<void> deleteById(int id) async {
    final prev = state;
    state = state.whenData((list) {
      final updatedList = list.where((r) => r.id != id).toList();
      list.removeWhere((r) => r.id == id); // Elimina el registro de la lista original
      return updatedList;
    });

    try {
      await eventScheduleUseCases.deleteEventScheduleById(id);
    } catch (_) {
      state = prev; // rollback si fallara
    }
  }
}

final eventScheduleProvider = AsyncNotifierProvider<EventScheduleNotifier, List<EventSchedule>>(() {
  return EventScheduleNotifier();
});
