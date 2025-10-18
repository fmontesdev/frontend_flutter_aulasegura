import 'package:frontend_flutter_aulasegura/features/home/domain/entities/subject.dart';

class SubjectModel extends Subject {
  const SubjectModel({
    required super.id,
    required super.name,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) => SubjectModel(
    id: json['subject_id'] as int,
    name: json['name'] as String,
  );

  Map<String, dynamic> toJson() => {
    'subject_id': id,
    'name': name,
  };
}