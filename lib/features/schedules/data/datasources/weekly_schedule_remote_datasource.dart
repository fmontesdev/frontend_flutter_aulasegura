import 'package:frontend_flutter_aulasegura/features/access/data/models/permission_model.dart';
import 'package:frontend_flutter_aulasegura/core/utils/app_services.dart';

class WeeklyScheduleRemoteDataSource {
  /// Llama a la API para obtener los horarios semanales del usuario autenticado
  Future<List<PermissionModel>> fetchMyWeeklySchedules() async {
    final response = await AppServices.dio.get('/permissions/my-weekly-schedules');

    return (response.data as List)
      .map((json) => PermissionModel.fromJson(json as Map<String, dynamic>))
      .toList();
  }
}