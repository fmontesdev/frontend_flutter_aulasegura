import 'package:frontend_flutter_aulasegura/features/schedules/domain/entities/weekly_schedule.dart';
import 'package:frontend_flutter_aulasegura/features/schedules/data/models/room_model.dart';
import 'package:frontend_flutter_aulasegura/features/schedules/data/models/subject_model.dart';


class WeeklyScheduleModel extends WeeklySchedule {
  const WeeklyScheduleModel({
    required super.id,
    required super.dayOfWeek,
    required super.startTime,
    required super.endTime,
    required super.room,
    super.subject,
    required super.userId,
  });

  factory WeeklyScheduleModel.fromJson(Map<String, dynamic> json) => WeeklyScheduleModel(
    id: json['schedule_id'] as int,
    dayOfWeek: json['day_of_week'] as int,
    startTime: json['start_time'] as String,
    endTime: json['end_time'] as String,
    room: RoomModel.fromJson(json['room'] as Map<String, dynamic>),
    subject: json['subject'] == null
        ? null
        : SubjectModel.fromJson(json['subject'] as Map<String, dynamic>),
    userId: json['user_id'] as String,
  );

  Map<String, dynamic> toJson() => {
  'schedule_id': id,
  'day_of_week': dayOfWeek,
  'start_time': startTime,
  'end_time': endTime,
  'room': (room as RoomModel).toJson(),
  'subject': subject == null
    ? null
    : (subject as SubjectModel).toJson(),
  'user_id': userId,
  };
}