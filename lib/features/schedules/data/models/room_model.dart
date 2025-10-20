import 'package:frontend_flutter_aulasegura/features/schedules/domain/entities/room.dart';
import 'package:frontend_flutter_aulasegura/features/schedules/data/models/course_model.dart';

class RoomModel extends Room {
  const RoomModel({
    required super.id,
    required super.name,
    super.course,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) => RoomModel(
    id: json['room_id'] as int,
    name: json['name'] as String,
    course: json['course'] == null
        ? null
        : CourseModel.fromJson(json['course'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'room_id': id,
    'name': name,
    'course': course == null
      ? null
      : (course as CourseModel).toJson(),
  };
}