import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/data/datasources/event_schedule_remote_datasource.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/data/repositories/event_schedule_repository_impl.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/domain/repositories/event_schedule_repository.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/domain/usecases/event_schedule_usecases.dart';
import 'package:frontend_flutter_aulasegura/features/auth/presentation/providers/auth_providers.dart';
import 'package:frontend_flutter_aulasegura/features/access/domain/entities/permission.dart';

/// DataSource con seed (fake_data)
final eventScheduleRemoteDSProvider = Provider<EventScheduleRemoteDataSource>((ref) {
  return EventScheduleRemoteDataSource();
});

/// Repositorio
final eventScheduleRepositoryProvider = Provider<EventScheduleRepository>((ref) {
  final ds = ref.watch(eventScheduleRemoteDSProvider);
  return EventScheduleRepositoryImpl(remoteDataSource: ds);
});

/// Casos de uso
final eventScheduleUseCasesProvider = Provider<EventScheduleUseCases>((ref) {
  final repo = ref.watch(eventScheduleRepositoryProvider);
  return EventScheduleUseCases(repo);
});

/// Notifier para manejar el estado de las reservas
class EventScheduleNotifier extends AsyncNotifier<List<Permission>> {
  /// Inicializa el Notifier
  @override
  Future<List<Permission>> build() async {
    final eventScheduleUseCases = ref.watch(eventScheduleUseCasesProvider);
    // Obtiene el usuario autenticado
    final user = await ref.watch(authProvider.future);
    if (user == null) {
      // Sin sesión no hay reservas
      return <Permission>[];
    }
    // Carga inicial de reservas del usuario autenticado
    return await eventScheduleUseCases.getMyActiveReservations();
  }

  /// Elimina una reserva/permiso por userId, roomId y scheduleId
  Future<void> delete(String userId, int roomId, int scheduleId) async {
    final prev = state;
    state = state.whenData((list) {
      final updatedList = list.where((permission) => 
        !(permission.user.id == userId && 
          permission.room.id == roomId && 
          permission.schedule.id == scheduleId)
      ).toList();
      return updatedList;
    });

    try {
      final eventScheduleUseCases = ref.read(eventScheduleUseCasesProvider);
      await eventScheduleUseCases.deleteReservation(userId, roomId, scheduleId);
    } catch (_) {
      state = prev; // rollback si fallara
      rethrow;
    }
  }

  /// Crea una nueva reserva/permiso
  Future<Permission> createReservation(
    String userId,
    int roomId,
    String description,
    DateTime startAt,
    DateTime endAt
  ) async {
    try {
      final eventScheduleUseCases = ref.read(eventScheduleUseCasesProvider);
      final Permission newReservation = await eventScheduleUseCases.createReservation(userId, roomId, description, startAt, endAt);

      // Actualiza el estado con la nueva reserva
      state = state.whenData((list) => [...list, newReservation]);

      return newReservation;
    } catch (error) {
      rethrow;
    }
  }
}

final eventScheduleProvider = AsyncNotifierProvider<EventScheduleNotifier, List<Permission>>(() {
  return EventScheduleNotifier();
});
