// ignore_for_file: prefer_final_fields

import 'package:frontend_flutter_aulasegura/features/reservations/data/models/event_schedule_model.dart';
import 'package:frontend_flutter_aulasegura/features/schedules/domain/entities/room.dart';

class EventScheduleLocalDataSource {
  List<EventScheduleModel> _eventScheduleList = [];

  // Constructor que recibe datos de eventos simulados
  EventScheduleLocalDataSource({required List<Map<String, dynamic>> seed})
    : _eventScheduleList = seed.map(EventScheduleModel.fromJson).toList();

  Future<List<EventScheduleModel>> fetchByUserId(String userId) async {
    return _eventScheduleList.where((s) => s.userId == userId).toList();
  }

  Future<EventScheduleModel> createByUserId({
    required String startAt,
    required String endAt,
    required String reservationStatusReason,
    required Room room,
    required String userId,
  }) async {
    final newEventSchedule = EventScheduleModel(
      id: _eventScheduleList.length + 1,
      eventType: 'reservation',
      startAt: startAt,
      endAt: endAt,
      status: 'pending',
      reservationStatusReason: reservationStatusReason,
      isActive: true,
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: null,
      room: room,
      userId: userId,
    );
    _eventScheduleList.add(newEventSchedule);
    return newEventSchedule;
  }

  Future<EventScheduleModel> updateById({
    required int id,
    String? startAt,
    String? endAt,
    String? status,
    String? reservationStatusReason,
    bool? isActive,
    Room? room,
  }) async {
    final index = _eventScheduleList.indexWhere((s) => s.id == id);
    if (index == -1) {
      throw Exception('EventSchedule with id $id not found');
    }
    final updatedEventSchedule = _eventScheduleList[index].copyWith(
      startAt: startAt ?? _eventScheduleList[index].startAt,
      endAt: endAt ?? _eventScheduleList[index].endAt,
      status: status ?? _eventScheduleList[index].status,
      reservationStatusReason: reservationStatusReason ?? _eventScheduleList[index].reservationStatusReason,
      isActive: isActive ?? _eventScheduleList[index].isActive,
      updatedAt: DateTime.now().toIso8601String(),
      room: room ?? _eventScheduleList[index].room,

    );
    _eventScheduleList[index] = updatedEventSchedule;
    return updatedEventSchedule;
  }

  Future<EventScheduleModel> deleteById(int id) async {
    final index = _eventScheduleList.indexWhere((s) => s.id == id);
    if (index == -1) {
      throw Exception('EventSchedule with id $id not found');
    }
    final deletedEventSchedule = _eventScheduleList.removeAt(index);
    return deletedEventSchedule;
  }
}