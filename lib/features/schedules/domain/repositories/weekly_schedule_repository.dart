import 'package:frontend_flutter_aulasegura/features/access/domain/entities/permission.dart';

abstract class WeeklyScheduleRepository {
  Future<List<Permission>> getMyWeeklySchedules();
}