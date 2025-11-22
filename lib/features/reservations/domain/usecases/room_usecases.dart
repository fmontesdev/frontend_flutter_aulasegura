import 'package:frontend_flutter_aulasegura/features/reservations/domain/entities/room.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/domain/repositories/room_repository.dart';

class RoomUseCases {
  final Future<List<Room>> Function(String date, String startAt, String endAt) getAvailableRooms;

  RoomUseCases(RoomRepository repo)
      : getAvailableRooms = repo.getAvailableRooms;
}
