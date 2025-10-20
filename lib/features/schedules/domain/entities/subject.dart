import 'package:equatable/equatable.dart';

class Subject extends Equatable {
  final int id;
  final String? subjectCode;
  final String name;
  final bool? isActive;

  const Subject({
    required this.id,
    this.subjectCode,
    required this.name,
    this.isActive,
  });

  Subject copyWith({
    int? id,
    String? name,
    String? subjectCode,
    bool? isActive,
  }) => Subject(
    id: id ?? this.id,
    name: name ?? this.name,
    subjectCode: subjectCode ?? this.subjectCode,
    isActive: isActive ?? this.isActive,
  );

  @override
  List<Object?> get props => [id, name, subjectCode, isActive];
}