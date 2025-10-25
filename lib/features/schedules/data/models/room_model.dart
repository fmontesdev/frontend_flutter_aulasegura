// ignore_for_file: prefer_if_null_operators

import 'package:frontend_flutter_aulasegura/features/schedules/domain/entities/room.dart';
import 'package:frontend_flutter_aulasegura/features/schedules/data/models/course_model.dart';

class RoomModel extends Room {
  const RoomModel({
    required super.id,
    required super.roomCode,
    required super.name,
    super.course,
    super.capacity,
    super.building,
    super.floor,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) => RoomModel(
    id: json['room_id'] as int,
    roomCode: json['room_code'] as String,
    name: json['name'] as String,
    course: json['course'] == null
        ? null
        : CourseModel.fromJson(json['course'] as Map<String, dynamic>),
    capacity: json['capacity'] == null
        ? null
        : json['capacity'] as int,
    building: json['building'] == null
        ? null
        : json['building'] as String,
    floor: json['floor'] == null
        ? null
        : json['floor'] as String,
  );

  Map<String, dynamic> toJson() => {
    'room_id': id,
    'room_code': roomCode,
    'name': name,
    'course': course == null
      ? null
      : (course as CourseModel).toJson(),
    'capacity': capacity == null
      ? null
      : capacity,
    'building': building == null
      ? null
      : building,
    'floor': floor == null
      ? null
      : floor,
  };
}