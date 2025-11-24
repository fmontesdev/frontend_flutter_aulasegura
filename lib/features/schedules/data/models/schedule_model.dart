import 'package:frontend_flutter_aulasegura/features/schedules/domain/entities/schedule.dart';
import 'package:frontend_flutter_aulasegura/features/schedules/data/models/academic_year_model.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/data/models/event_schedule_model.dart';
import 'package:frontend_flutter_aulasegura/features/schedules/data/models/weekly_schedule_model.dart';

class ScheduleModel extends Schedule {
  const ScheduleModel({
    required super.id,
    required super.type,
    required super.academicYear,
    required super.isActive,
    required super.createdAt,
    super.updatedAt,
    super.weeklySchedule,
    super.eventSchedule,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
    id: json['scheduleId'] as int,
    type: json['type'] as String,
    academicYear: AcademicYearModel.fromJson(json['academicYear'] as Map<String, dynamic>),
    isActive: json['isActive'] as bool,
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: json['updatedAt'] == null 
        ? null 
        : DateTime.parse(json['updatedAt'] as String),
    weeklySchedule: json['weeklySchedule'] == null
        ? null
        : WeeklyScheduleModel.fromJson(json['weeklySchedule'] as Map<String, dynamic>),
    eventSchedule: json['eventSchedule'] == null
        ? null
        : EventScheduleModel.fromJson(json['eventSchedule'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'scheduleId': id,
    'type': type,
    'academicYear': academicYear.toJson(),
    'isActive': isActive,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    'weeklySchedule': weeklySchedule == null
      ? null
      : (weeklySchedule as WeeklyScheduleModel).toJson(),
    'eventSchedule': eventSchedule == null
      ? null
      : (eventSchedule as EventScheduleModel).toJson(),
  };
}
