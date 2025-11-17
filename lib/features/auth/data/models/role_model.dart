import 'package:frontend_flutter_aulasegura/features/auth/domain/entities/role.dart';

class RoleModel extends Role {
  const RoleModel({
    super.id,
    required super.name,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) => RoleModel(
    id: json['roleId'] as int,
    name: json['name'] as String,
  );

  Map<String, dynamic> toJson() => {
    'roleId': id,
    'name': name,
  };
}