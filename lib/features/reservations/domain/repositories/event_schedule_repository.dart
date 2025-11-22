import 'package:frontend_flutter_aulasegura/features/access/domain/entities/permission.dart';

abstract class EventScheduleRepository {
  Future<List<Permission>> getMyActiveReservations();

  Future<void> deleteReservation(String userId, int roomId, int scheduleId);

  Future<Permission> createReservation(
    String userId,
    int roomId,
    String description,
    DateTime startAt,
    DateTime endAt
  );
}