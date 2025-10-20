import 'package:frontend_flutter_aulasegura/features/reservations/domain/entities/event_schedule.dart';
import 'package:frontend_flutter_aulasegura/features/schedules/domain/entities/room.dart';

abstract class EventScheduleRepository {
  Future<List<EventSchedule>> getEventSchedulesByUserId(String userId);

  Future<EventSchedule> createEventScheduleByUserId(
    String startAt,
    String endAt,
    String reason,
    Room room,
    String userId
  );

  Future<EventSchedule> updateEventScheduleById(
    int id,
    String startAt,
    String endAt,
    String status,
    String reason,
    bool isActive,
    Room room,
  );

  Future<EventSchedule> deleteEventScheduleById(int id);
}