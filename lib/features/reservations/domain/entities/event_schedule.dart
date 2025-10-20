import 'package:equatable/equatable.dart';
import 'package:frontend_flutter_aulasegura/features/schedules/domain/entities/room.dart';

class EventSchedule extends Equatable {
  final int id;
  final String type;
  final String startAt;
  final String endAt;
  final String status;
  final String reason;
  final bool? isActive;
  final String createdAt;
  final String? updatedAt;
  final Room room;
  final String userId;

  const EventSchedule({
    required this.id,
    required this.type,
    required this.startAt,
    required this.endAt,
    required this.status,
    required this.reason,
    this.isActive,
    required this.createdAt,
    this.updatedAt,
    required this.room,
    required this.userId,
  });

  EventSchedule copyWith({
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
  }) => EventSchedule(
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

  @override
  List<Object?> get props => [
    id,
    type,
    startAt,
    endAt,
    status,
    reason,
    isActive,
    createdAt,
    updatedAt,
    room,
    userId,
  ];
}
