import 'package:frontend_flutter_aulasegura/features/auth/domain/entities/role.dart';

class RoleModel extends Role {
  const RoleModel({
    required super.id,
    required super.name,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) => RoleModel(
    id: json['role_id'] as int,
    name: json['name'] as String,
  );

  Map<String, dynamic> toJson() => {
    'role_id': id,
    'name': name,
  };
}