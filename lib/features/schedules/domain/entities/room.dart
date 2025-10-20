import 'package:equatable/equatable.dart';
import 'package:frontend_flutter_aulasegura/features/schedules/domain/entities/course.dart';

class Room extends Equatable {
  final int id;
  final String? roomCode;
  final String name;
  final Course? course;
  final int? capacity;
  final String? floor;

  const Room({
    required this.id,
    this.roomCode,
    required this.name,
    this.course,
    this.capacity,
    this.floor,
  });

  Room copyWith({
    int? id,
    String? roomCode,
    String? name,
    Course? course,
    int? capacity,
    String? floor,
  }) => Room(
    id: id ?? this.id,
    roomCode: roomCode ?? this.roomCode,
    name: name ?? this.name,
    course: course ?? this.course,
    capacity: capacity ?? this.capacity,
    floor: floor ?? this.floor,
  );

  @override
  List<Object?> get props => [id, roomCode, name, course, capacity, floor];
}