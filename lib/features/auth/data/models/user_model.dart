import 'package:frontend_flutter_aulasegura/features/auth/domain/entities/user.dart';
import 'package:frontend_flutter_aulasegura/features/auth/data/models/role_model.dart';
import 'package:frontend_flutter_aulasegura/features/auth/data/models/department_model.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.lastName,
    required super.email,
    required super.avatar,
    required super.role,
    super.department,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['user_id'] as String,
    name: json['name'] as String,
    lastName: json['last_name'] as String,
    email: json['email'] as String,
    avatar: json['user_img'] as String,
    role: RoleModel.fromJson(json['role'] as Map<String, dynamic>),
    department: json['department'] == null
        ? null
        : DepartmentModel.fromJson(json['department'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'user_id': id,
    'name': name,
    'last_name': lastName,
    'email': email,
    'user_img': avatar,
    'role': (role as RoleModel).toJson(),
    'department': department == null
      ? null
      : (department as DepartmentModel).toJson(),
  };
}