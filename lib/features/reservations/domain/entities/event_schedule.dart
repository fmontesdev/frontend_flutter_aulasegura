import 'package:equatable/equatable.dart';
import 'package:frontend_flutter_aulasegura/features/schedules/domain/entities/room.dart';

class EventSchedule extends Equatable {
  final int? id;
  final String eventType;
  final String? description;
  final String startAt;
  final String endAt;
  final String status;
  final String? reservationStatusReason;
  final bool? isActive;
  final String? createdAt;
  final String? updatedAt;
  final Room? room;
  final String? userId;

  const EventSchedule({
    this.id,
    required this.eventType,
    this.description,
    required this.startAt,
    required this.endAt,
    required this.status,
    this.reservationStatusReason,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.room,
    this.userId,
  });

  EventSchedule copyWith({
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
  }) => EventSchedule(
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

  @override
  List<Object?> get props => [
    id,
    eventType,
    description,
    startAt,
    endAt,
    status,
    reservationStatusReason,
    isActive,
    createdAt,
    updatedAt,
    room,
    userId,
  ];
}
