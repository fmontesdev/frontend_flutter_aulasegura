import 'package:equatable/equatable.dart';
import 'package:frontend_flutter_aulasegura/features/access/domain/entities/permission.dart';

class AccessCheck extends Equatable {
  final Permission? permission;
  final String accessStatus;
  final String? reasonStatus;

  const AccessCheck({
    this.permission,
    required this.accessStatus,
    required this.reasonStatus,
  });

  @override
  List<Object?> get props => [permission, accessStatus, reasonStatus];
}
