import 'package:frontend_flutter_aulasegura/features/schedules/domain/entities/course.dart';

class CourseModel extends Course {
  const CourseModel({
    required super.id,
    required super.name,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
    id: json['course_id'] as int,
    name: json['name'] as String,
  );

  Map<String, dynamic> toJson() => {
    'course_id': id,
    'name': name,
  };
}