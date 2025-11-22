import 'package:equatable/equatable.dart';

class Room extends Equatable {
  final int id;
  final String roomCode;
  final String name;
  final String? courseName;
  final int? capacity;
  final int? building;
  final int? floor;

  const Room({
    required this.id,
    required this.roomCode,
    required this.name,
    this.courseName,
    this.capacity,
    this.building,
    this.floor,
  });

  Room copyWith({
    int? id,
    String? roomCode,
    String? name,
    String? courseName,
    int? capacity,
    int? building,
    int? floor,
  }) => Room(
    id: id ?? this.id,
    roomCode: roomCode ?? this.roomCode,
    name: name ?? this.name,
    courseName: courseName ?? this.courseName,
    capacity: capacity ?? this.capacity,
    building: building ?? this.building,
    floor: floor ?? this.floor,
  );

  @override
  List<Object?> get props => [id, roomCode, name, courseName, capacity, building, floor];
}