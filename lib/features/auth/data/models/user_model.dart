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
    required super.roles,
    super.department,
    super.accessToken,
    super.refreshToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['userId'] as String,
    name: json['name'] as String,
    lastName: json['lastname'] as String,
    email: json['email'] as String,
    avatar: json['avatar'] as String,
    roles: (json['roles'] as List).map((role) =>
      role is String
          ? RoleModel(name: role)
          : RoleModel.fromJson(role as Map<String, dynamic>)
    ).toList(),
    department: json['department'] == null
        ? null
        : DepartmentModel.fromJson(json['department'] as Map<String, dynamic>),
    accessToken: json['accessToken'] as String?,
    refreshToken: json['refreshToken'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'userId': id,
    'name': name,
    'lastname': lastName,
    'email': email,
    'avatar': avatar,
    'roles': roles.map((role) => (role as RoleModel).toJson()).toList(),
    'department': department == null
      ? null
      : (department as DepartmentModel).toJson(),
    'accessToken': accessToken,
    'refreshToken': refreshToken,
  };
}