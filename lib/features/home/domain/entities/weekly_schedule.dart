import 'package:equatable/equatable.dart';
import 'package:frontend_flutter_aulasegura/features/home/domain/entities/room.dart';
import 'package:frontend_flutter_aulasegura/features/home/domain/entities/subject.dart';

class WeeklySchedule extends Equatable {
  final int id;
  final int dayOfWeek;
  final String startTime;
  final String endTime;
  final DateTime? validFrom;
  final DateTime? validTo;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Room room;
  final Subject? subject;
  final String userId;

  const WeeklySchedule({
    required this.id,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    this.validFrom,
    this.validTo,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    required this.room,
    this.subject,
    required this.userId,
  });

  WeeklySchedule copyWith({
    int? id,
    int? dayOfWeek,
    String? startTime,
    String? endTime,
    DateTime? validFrom,
    DateTime? validTo,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    Room? room,
    Subject? subject,
    String? userId,
  }) => WeeklySchedule(
    id: id ?? this.id,
    dayOfWeek: dayOfWeek ?? this.dayOfWeek,
    startTime: startTime ?? this.startTime,
    endTime: endTime ?? this.endTime,
    validFrom: validFrom ?? this.validFrom,
    validTo: validTo ?? this.validTo,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    room: room ?? this.room,
    subject: subject ?? this.subject,
    userId: userId ?? this.userId,
  );

  @override
  List<Object?> get props => [
    id,
    dayOfWeek,
    startTime,
    endTime,
    validFrom,
    validTo,
    isActive,
    createdAt,
    updatedAt,
    room,
    subject,
    userId,
  ];
}
