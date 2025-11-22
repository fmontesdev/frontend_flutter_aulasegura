import 'package:frontend_flutter_aulasegura/core/utils/app_services.dart';
import 'package:frontend_flutter_aulasegura/features/access/data/models/permission_model.dart';

class EventScheduleRemoteDataSource {
  /// Obtiene las reservas activas del usuario autenticado
  Future<List<PermissionModel>> fetchMyActiveReservations() async {
    final response = await AppServices.dio.get('/permissions/my-reservations');
    
    return (response.data as List)
      .map((json) => PermissionModel.fromJson(json as Map<String, dynamic>))
      .toList();
  }

  /// Elimina una reserva/permiso por [userId][roomId][scheduleId]
  Future<void> deleteReservation(String userId, int roomId, int scheduleId) async {
    await AppServices.dio.delete('/permissions/delete/$userId/$roomId/$scheduleId');
  }

  /// Crea una nueva reserva/permiso
  Future<PermissionModel> createReservation(
    String userId,
    int roomId,
    String description,
    DateTime startAt,
    DateTime endAt
  ) async {
    final response = await AppServices.dio.post(
      '/permissions/event-schedule',
      data: { 
        'userId': userId,
        'roomId': roomId,
        'description': description,
        'startAt': startAt.toIso8601String(),
        'endAt': endAt.toIso8601String(),
      },
    );
    return PermissionModel.fromJson(response.data);
  }
}