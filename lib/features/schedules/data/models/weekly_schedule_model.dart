import 'package:frontend_flutter_aulasegura/features/schedules/domain/entities/weekly_schedule.dart';

class WeeklyScheduleModel extends WeeklySchedule {
  const WeeklyScheduleModel({
    required super.dayOfWeek,
    required super.startTime,
    required super.endTime,
  });

  factory WeeklyScheduleModel.fromJson(Map<String, dynamic> json) => WeeklyScheduleModel(
    dayOfWeek: json['dayOfWeek'] as int,
    startTime: json['startTime'] as String,
    endTime: json['endTime'] as String,
  );

  Map<String, dynamic> toJson() => {
  'dayOfWeek': dayOfWeek,
  'startTime': startTime,
  'endTime': endTime,
  };
}