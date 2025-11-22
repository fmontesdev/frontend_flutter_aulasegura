import 'package:equatable/equatable.dart';
import 'package:frontend_flutter_aulasegura/features/auth/domain/entities/user.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/domain/entities/room.dart';
import 'package:frontend_flutter_aulasegura/features/schedules/domain/entities/schedule.dart';

class Permission extends Equatable {
  final User user;
  final Room room;
  final Schedule schedule;
  final String createdById;
  final DateTime createdAt;
  final bool isActive;

  const Permission({
    required this.user,
    required this.room,
    required this.schedule,
    required this.createdById,
    required this.createdAt,
    required this.isActive,
  });

  @override
  List<Object?> get props => [user, room, schedule, createdById, createdAt, isActive];
}
