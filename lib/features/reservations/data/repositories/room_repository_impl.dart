import 'package:frontend_flutter_aulasegura/features/reservations/data/datasources/room_remote_datasource.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/domain/entities/room.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/domain/repositories/room_repository.dart';

class RoomRepositoryImpl implements RoomRepository {
  final RoomRemoteDataSource remoteDataSource;

  RoomRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Room>> getAvailableRooms(String date, String startAt, String endAt) async {
    final roomModels = await remoteDataSource.fetchAvailableRooms(date, startAt, endAt);
    return roomModels;
  }
}
