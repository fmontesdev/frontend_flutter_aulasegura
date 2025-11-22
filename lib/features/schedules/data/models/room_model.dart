import 'package:frontend_flutter_aulasegura/features/schedules/domain/entities/room.dart';

class RoomModel extends Room {
  const RoomModel({
    required super.id,
    required super.roomCode,
    required super.name,
    super.courseName,
    super.capacity,
    super.building,
    super.floor,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) => RoomModel(
    id: json['roomId'] as int,
    roomCode: json['roomCode'] as String,
    name: json['name'] as String,
    courseName: json['courseName'] == null
        ? null
        : json['courseName'] as String,
    capacity: json['capacity'] == null
        ? null
        : json['capacity'] as int,
    building: json['building'] == null
        ? null
        : json['building'] as int,
    floor: json['floor'] == null
        ? null
        : json['floor'] as int,
    // Ignorar campo extra del backend (readers)
  );

  Map<String, dynamic> toJson() => {
    'roomId': id,
    'roomCode': roomCode,
    'name': name,
    'courseName': courseName,
    'capacity': capacity,
    'building': building,
    'floor': floor,
  };
}