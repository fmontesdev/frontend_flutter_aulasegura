import 'package:frontend_flutter_aulasegura/core/utils/app_services.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/data/models/room_model.dart';

class RoomRemoteDataSource {
  /// Obtiene las aulas disponibles para reservar a partir de la fecha y rangos horarios elegidos
  Future<List<RoomModel>> fetchAvailableRooms(String date, String startAt, String endAt) async {
    final response = await AppServices.dio.get(
      '/rooms/available',
      queryParameters: {
        'date': date,
        'startAt': startAt,
        'endAt': endAt,
      },
    );

    return (response.data as List)
        .map((json) => RoomModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
