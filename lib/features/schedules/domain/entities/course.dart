import 'package:equatable/equatable.dart';

class Course extends Equatable {
  final int id;
  final String? courseCode;
  final String name;
  final String? level;
  final int? stage;
  final bool? isActive;

  const Course({
    required this.id,
    required this.name,
    this.courseCode,
    this.level,
    this.stage,
    this.isActive,
  });

  Course copyWith({
    int? id,
    String? courseCode,
    String? name,
    String? level,
    int? stage,
    bool? isActive,
  }) => Course(
    id: id ?? this.id,
    courseCode: courseCode ?? this.courseCode,
    name: name ?? this.name,
    level: level ?? this.level,
    stage: stage ?? this.stage,
    isActive: isActive ?? this.isActive,
  );

  @override
  List<Object?> get props => [id, name, courseCode, level, stage, isActive];
}