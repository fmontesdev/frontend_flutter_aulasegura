import 'package:frontend_flutter_aulasegura/features/reservations/data/datasources/event_schedule_remote_datasource.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/domain/repositories/event_schedule_repository.dart';
import 'package:frontend_flutter_aulasegura/features/access/domain/entities/permission.dart';

class EventScheduleRepositoryImpl implements EventScheduleRepository {
  final EventScheduleRemoteDataSource remoteDataSource;
  EventScheduleRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Permission>> getMyActiveReservations() async {
    final permissionModel = await remoteDataSource.fetchMyActiveReservations();
    return permissionModel;
  }

  @override
  Future<void> deleteReservation(String userId, int roomId, int scheduleId) async {
    await remoteDataSource.deleteReservation(userId, roomId, scheduleId);
  }

  @override
  Future<Permission> createReservation(
    String userId,
    int roomId,
    String description,
    DateTime startAt,
    DateTime endAt
  ) async {
    final permissionModel = await remoteDataSource.createReservation(
      userId,
      roomId,
      description,
      startAt,
      endAt
    );
    return permissionModel;
  }
}