// ignore_for_file: prefer_if_null_operators

import 'package:frontend_flutter_aulasegura/features/reservations/domain/entities/event_schedule.dart';
import 'package:frontend_flutter_aulasegura/features/schedules/data/models/room_model.dart';
import 'package:frontend_flutter_aulasegura/features/schedules/domain/entities/room.dart';

class EventScheduleModel extends EventSchedule {
  const EventScheduleModel({
    required super.id,
    required super.type,
    required super.startAt,
    required super.endAt,
    required super.status,
    required super.reason,
    super.isActive,
    required super.createdAt,
    super.updatedAt,
    required super.room,
    required super.userId,
  });

  @override
  EventScheduleModel copyWith({
    int? id,
    String? type,
    String? startAt,
    String? endAt,
    String? status,
    String? reason,
    bool? isActive,
    String? createdAt,
    String? updatedAt,
    Room? room,
    String? userId,
  }) => EventScheduleModel(
    id: id ?? this.id,
    type: type ?? this.type,
    startAt: startAt ?? this.startAt,
    endAt: endAt ?? this.endAt,
    status: status ?? this.status,
    reason: reason ?? this.reason,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    room: room ?? this.room,
    userId: userId ?? this.userId,
  );

  factory EventScheduleModel.fromJson(Map<String, dynamic> json) => EventScheduleModel(
    id: json['schedule_id'] as int,
    type: json['type'] as String,
    startAt: json['start_at'] as String,
    endAt: json['end_at'] as String,
    status: json['status'] as String,
    reason: json['reason'] as String,
    // isActive: json['is_active'] as bool,
    isActive: json['is_active'] == null
        ? true
        : json['is_active'] as bool,
    createdAt: json['created_at'] as String,
    updatedAt: json['updated_at'] == null
        ? null
        : json['updated_at'] as String,
    room: RoomModel.fromJson(json['room']),
    userId: json['user_id'] as String,
  );

  Map<String, dynamic> toJson() => {
  'schedule_id': id,
  'type': type,
  'start_at': startAt,
  'end_at': endAt,
  'status': status,
  'reason': reason,
  // 'is_active': isActive,
  'is_active': isActive == null
    ? null
    : isActive,
  'created_at': createdAt,
  'updated_at': updatedAt == null
    ? null
    : updatedAt,
  'room': (room as RoomModel).toJson(),
  'user_id': userId,
  };
}