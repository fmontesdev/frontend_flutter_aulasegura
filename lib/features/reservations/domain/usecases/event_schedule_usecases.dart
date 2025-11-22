import 'package:frontend_flutter_aulasegura/features/reservations/domain/repositories/event_schedule_repository.dart';
import 'package:frontend_flutter_aulasegura/features/access/domain/entities/permission.dart';

class EventScheduleUseCases {
  final Future<List<Permission>> Function() getMyActiveReservations;
  final Future<void> Function(String userId, int roomId, int scheduleId) deleteReservation;
  final Future<Permission> Function(
    String userId,
    int roomId,
    String description,
    DateTime startAt,
    DateTime endAt
  ) createReservation;

  EventScheduleUseCases(EventScheduleRepository repo)
    : getMyActiveReservations = repo.getMyActiveReservations,
      deleteReservation = repo.deleteReservation,
      createReservation = repo.createReservation;
}