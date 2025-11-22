import 'package:frontend_flutter_aulasegura/features/reservations/domain/entities/event_schedule.dart';
import 'package:frontend_flutter_aulasegura/features/schedules/data/models/room_model.dart';
import 'package:frontend_flutter_aulasegura/features/schedules/domain/entities/room.dart';

class EventScheduleModel extends EventSchedule {
  const EventScheduleModel({
    super.id,
    required super.eventType,
    super.description,
    required super.startAt,
    required super.endAt,
    required super.status,
    super.reservationStatusReason,
    super.isActive,
    super.createdAt,
    super.updatedAt,
    super.room,
    super.userId,
  });

  @override
  EventScheduleModel copyWith({
    int? id,
    String? eventType,
    String? description,
    String? startAt,
    String? endAt,
    String? status,
    String? reservationStatusReason,
    bool? isActive,
    String? createdAt,
    String? updatedAt,
    Room? room,
    String? userId,
  }) => EventScheduleModel(
    id: id ?? this.id,
    eventType: eventType ?? this.eventType,
    description: description ?? this.description,
    startAt: startAt ?? this.startAt,
    endAt: endAt ?? this.endAt,
    status: status ?? this.status,
    reservationStatusReason: reservationStatusReason ?? this.reservationStatusReason,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    room: room ?? this.room,
    userId: userId ?? this.userId,
  );

  factory EventScheduleModel.fromJson(Map<String, dynamic> json) => EventScheduleModel(
    id: json['schedule_id'] == null
        ? null
        :json['schedule_id'] as int?,
    eventType: json['eventType'] as String,
    description: json['description'] == null
        ? null
        : json['description'] as String,
    startAt: json['startAt'] as String,
    endAt: json['endAt'] as String,
    status: json['status'] as String,
    reservationStatusReason: json['reservationStatusReason'] == null
        ? null
        : json['reservationStatusReason'] as String,
    isActive: json['is_active'] == null
        ? true
        : json['is_active'] as bool,
    createdAt: json['created_at'] == null
        ? null
        : json['created_at'] as String,
    updatedAt: json['updated_at'] == null
        ? null
        : json['updated_at'] as String,
    room: json['room'] != null ? RoomModel.fromJson(json['room']) : null,
    userId: json['user_id'] == null
        ? null
        : json['user_id'] as String,
  );

  Map<String, dynamic> toJson() => {
  'schedule_id': id,
  'eventType': eventType,
  'description': description,
  'startAt': startAt,
  'endAt': endAt,
  'status': status,
  'reservationStatusReason': reservationStatusReason,
  'is_active': isActive,
  'created_at': createdAt,
  'updated_at': updatedAt,
  'room': (room as RoomModel).toJson(),
  'user_id': userId,
  };
}