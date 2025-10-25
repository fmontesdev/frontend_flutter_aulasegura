import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/data/datasources/time_slot_local_datasource.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/data/repositories/time_slot_repository_impl.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/domain/repositories/time_slot_repository.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/domain/usecases/time_slot_usecases.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/domain/entities/time_slot.dart';
import 'package:frontend_flutter_aulasegura/fake_data/time_slots_list.dart' as seed_data;

/// DataSource con seed (fake_data)
final timeSlotLocalDSProvider = Provider<TimeSlotLocalDataSource>((ref) {
  return TimeSlotLocalDataSource(seed: seed_data.timeSlots);
});

/// Repositorio
final timeSlotRepositoryProvider = Provider<TimeSlotRepository>((ref) {
  final ds = ref.watch(timeSlotLocalDSProvider);
  return TimeSlotRepositoryImpl(localDataSource: ds);
});

/// Casos de uso
final timeSlotUseCasesProvider = Provider<TimeSlotUseCases>((ref) {
  final repo = ref.watch(timeSlotRepositoryProvider);
  return TimeSlotUseCases(repo);
});

/// Notifier para manejar el estado de las reservas
class TimeSlotNotifier extends AsyncNotifier<List<TimeSlot>> {
  late final TimeSlotUseCases timeSlotUseCases;

  /// Inicializa el Notifier
  @override
  Future<List<TimeSlot>> build() async {
    timeSlotUseCases = ref.watch(timeSlotUseCasesProvider);
    // Carga inicial de franjas horarias
    return await timeSlotUseCases.getTimeSlots();
  }
}

final timeSlotProvider = AsyncNotifierProvider<TimeSlotNotifier, List<TimeSlot>>(() {
  return TimeSlotNotifier();
});
