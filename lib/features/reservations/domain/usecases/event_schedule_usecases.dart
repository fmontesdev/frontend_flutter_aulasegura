import 'package:frontend_flutter_aulasegura/features/reservations/domain/entities/event_schedule.dart';
import 'package:frontend_flutter_aulasegura/features/schedules/domain/entities/room.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/domain/repositories/event_schedule_repository.dart';

class EventScheduleUseCases {
  final Future<List<EventSchedule>> Function(String userId) getEventSchedulesByUserId;
  final Future<EventSchedule> Function(
    String startAt,
    String endAt,
    String reason,
    Room room,
    String userId
  ) createEventScheduleByUserId;
  final Future<EventSchedule> Function(
    int id,
    String startAt,
    String endAt,
    String status,
    String reason,
    bool isActive,
    Room room,
  ) updateEventScheduleById;
  final Future<EventSchedule> Function(int id) deleteEventScheduleById;

  EventScheduleUseCases(EventScheduleRepository repo)
    : getEventSchedulesByUserId = repo.getEventSchedulesByUserId,
      createEventScheduleByUserId = repo.createEventScheduleByUserId,
      updateEventScheduleById = repo.updateEventScheduleById,
      deleteEventScheduleById = repo.deleteEventScheduleById;
}