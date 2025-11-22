import 'package:frontend_flutter_aulasegura/features/schedules/domain/entities/weekly_schedule.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/data/models/room_model.dart';
import 'package:frontend_flutter_aulasegura/features/schedules/data/models/subject_model.dart';

class WeeklyScheduleModel extends WeeklySchedule {
  const WeeklyScheduleModel({
    super.id,
    required super.dayOfWeek,
    required super.startTime,
    required super.endTime,
    super.room,
    super.subject,
    super.userId,
  });

  factory WeeklyScheduleModel.fromJson(Map<String, dynamic> json) => WeeklyScheduleModel(
    id: json['schedule_id'] == null
        ? null
        : json['schedule_id'] as int,
    dayOfWeek: json['dayOfWeek'] as int,
    startTime: json['startTime'] as String,
    endTime: json['endTime'] as String,
    room: json['room'] == null
        ? null
        : RoomModel.fromJson(json['room'] as Map<String, dynamic>),
    subject: json['subject'] == null
        ? null
        : SubjectModel.fromJson(json['subject'] as Map<String, dynamic>),
    userId: json['user_id'] == null
        ? null
        : json['user_id'] as String,
  );

  Map<String, dynamic> toJson() => {
  'schedule_id': id,
  'dayOfWeek': dayOfWeek,
  'startTime': startTime,
  'endTime': endTime,
  'room': room == null
    ? null
    : (room as RoomModel).toJson(),
  'subject': subject == null
    ? null
    : (subject as SubjectModel).toJson(),
  'user_id': userId,
  };
}