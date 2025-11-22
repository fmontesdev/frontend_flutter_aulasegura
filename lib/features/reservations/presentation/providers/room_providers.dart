import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/data/datasources/room_remote_datasource.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/data/repositories/room_repository_impl.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/domain/repositories/room_repository.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/domain/usecases/room_usecases.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/domain/entities/room.dart';

/// DataSource remoto
final roomRemoteDSProvider = Provider<RoomRemoteDataSource>((ref) {
  return RoomRemoteDataSource();
});

/// Repositorio
final roomRepositoryProvider = Provider<RoomRepository>((ref) {
  final ds = ref.watch(roomRemoteDSProvider);
  return RoomRepositoryImpl(remoteDataSource: ds);
});

/// Casos de uso
final roomUseCasesProvider = Provider<RoomUseCases>((ref) {
  final repo = ref.watch(roomRepositoryProvider);
  return RoomUseCases(repo);
});

/// Notifier para manejar las salas disponibles
class RoomNotifier extends Notifier<void> {
  @override
  void build() {
    // Sin estado inicial
  }

  /// Obtiene las aulas disponibles para reservar a partir de la fecha y rangos horarios elegidos
  Future<List<Room>> getAvailableRooms(String date, String startAt, String endAt) async {
    try {
      final roomUseCases = ref.read(roomUseCasesProvider);
      return await roomUseCases.getAvailableRooms(date, startAt, endAt);
    } catch (error) {
      rethrow;
    }
  }
}

final roomProvider = NotifierProvider<RoomNotifier, void>(() {
  return RoomNotifier();
});
