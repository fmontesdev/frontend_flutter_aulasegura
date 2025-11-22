import 'package:frontend_flutter_aulasegura/features/access/domain/entities/permission.dart';
import 'package:frontend_flutter_aulasegura/features/auth/data/models/user_model.dart';
import 'package:frontend_flutter_aulasegura/features/schedules/data/models/room_model.dart';
import 'package:frontend_flutter_aulasegura/features/schedules/data/models/schedule_model.dart';

class PermissionModel extends Permission {
  const PermissionModel({
    required super.user,
    required super.room,
    required super.schedule,
    required super.createdById,
    required super.createdAt,
    required super.isActive,
  });

  factory PermissionModel.fromJson(Map<String, dynamic> json) => PermissionModel(
    user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    room: RoomModel.fromJson(json['room'] as Map<String, dynamic>),
    schedule: ScheduleModel.fromJson(json['schedule'] as Map<String, dynamic>),
    createdById: json['createdById'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
    isActive: json['isActive'] as bool,
  );

  Map<String, dynamic> toJson() => {
    'user': (user as UserModel).toJson(),
    'room': (room as RoomModel).toJson(),
    'schedule': (schedule as ScheduleModel).toJson(),
    'createdById': createdById,
    'createdAt': createdAt.toIso8601String(),
    'isActive': isActive,
  };
}
