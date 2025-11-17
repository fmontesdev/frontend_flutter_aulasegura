import 'package:frontend_flutter_aulasegura/features/auth/domain/entities/department.dart';

class DepartmentModel extends Department {
  const DepartmentModel({
    required super.id,
    required super.name,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) => DepartmentModel(
    id: json['departmentId'] as int,
    name: json['name'] as String,
  );

  Map<String, dynamic> toJson() => {
    'departmentId': id,
    'name': name,
  };
}