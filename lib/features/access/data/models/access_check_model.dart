import 'package:frontend_flutter_aulasegura/features/access/domain/entities/access_check.dart';
import 'package:frontend_flutter_aulasegura/features/access/data/models/permission_model.dart';

class AccessCheckModel extends AccessCheck {
  const AccessCheckModel({
    super.permission,
    required super.accessStatus,
    required super.reasonStatus,
  });

  factory AccessCheckModel.fromJson(Map<String, dynamic> json) => AccessCheckModel(
    permission: json['permission'] == null
      ? null
      : PermissionModel.fromJson(json['permission'] as Map<String, dynamic>),
    accessStatus: json['accessStatus'] as String,
    reasonStatus: json['reasonStatus'] as String,
  );

  Map<String, dynamic> toJson() => {
    'permission': permission == null
      ? null
      : (permission as PermissionModel).toJson(),
    'accessStatus': accessStatus,
    'reasonStatus': reasonStatus,
  };
}
