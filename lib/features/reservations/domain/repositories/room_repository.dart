import 'package:frontend_flutter_aulasegura/features/reservations/domain/entities/room.dart';

abstract class RoomRepository {
  Future<List<Room>> getAvailableRooms(String date, String startAt, String endAt);
}
