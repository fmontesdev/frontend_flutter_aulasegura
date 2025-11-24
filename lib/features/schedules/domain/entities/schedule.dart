import 'package:equatable/equatable.dart';
import 'package:frontend_flutter_aulasegura/features/schedules/data/models/academic_year_model.dart';
import 'package:frontend_flutter_aulasegura/features/schedules/data/models/weekly_schedule_model.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/data/models/event_schedule_model.dart';

class Schedule extends Equatable {
  final int id;
  final String type;
  final AcademicYearModel academicYear;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final WeeklyScheduleModel? weeklySchedule;
  final EventScheduleModel? eventSchedule;

  const Schedule({
    required this.id,
    required this.type,
    required this.academicYear,
    required this.isActive,
    required this.createdAt,
    this.updatedAt,
    this.weeklySchedule,
    this.eventSchedule,
  });

  @override
  List<Object?> get props => [
    id,
    type,
    academicYear,
    isActive,
    createdAt,
    updatedAt,
    weeklySchedule,
    eventSchedule,
  ];
}
