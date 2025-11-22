import 'package:frontend_flutter_aulasegura/features/reservations/data/datasources/event_schedule_local_datasource.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/domain/entities/event_schedule.dart';
import 'package:frontend_flutter_aulasegura/features/schedules/domain/entities/room.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/domain/repositories/event_schedule_repository.dart';

class EventScheduleRepositoryImpl implements EventScheduleRepository {
  final EventScheduleLocalDataSource localDataSource;
  EventScheduleRepositoryImpl({required this.localDataSource});

  @override
  Future<List<EventSchedule>> getEventSchedulesByUserId(String userId) async {
    final eventSchedulesModel = await localDataSource.fetchByUserId(userId);
    return eventSchedulesModel;
  }

  @override
  Future<EventSchedule> createEventScheduleByUserId(
    String startAt,
    String endAt,
    String reservationStatusReason,
    Room room,
    String userId
  ) async {
    final eventScheduleModel = await localDataSource.createByUserId(
      startAt: startAt,
      endAt: endAt,
      reservationStatusReason: reservationStatusReason,
      room: room,
      userId: userId,
    );
    return eventScheduleModel;
  }

  @override
  Future<EventSchedule> updateEventScheduleById(
    int id,
    String startAt,
    String endAt,
    String status,
    String reservationStatusReason,
    bool isActive,
    Room room,
  ) async {
    final eventScheduleModel = await localDataSource.updateById(
      id: id,
      startAt: startAt,
      endAt: endAt,
      status: status,
      reservationStatusReason: reservationStatusReason,
      isActive: isActive,
      room: room,
    );
    return eventScheduleModel;
  }

  @override
  Future<EventSchedule> deleteEventScheduleById(int id) async {
    final eventScheduleModel = await localDataSource.deleteById(id);
    return eventScheduleModel;
  }
}