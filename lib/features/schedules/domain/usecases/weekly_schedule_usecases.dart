import 'package:frontend_flutter_aulasegura/features/schedules/domain/repositories/weekly_schedule_repository.dart';
import 'package:frontend_flutter_aulasegura/features/access/domain/entities/permission.dart';

class WeeklyScheduleUseCases {
  final Future<List<Permission>> Function() getMyWeeklySchedules;

  WeeklyScheduleUseCases(WeeklyScheduleRepository repo)
    : getMyWeeklySchedules = repo.getMyWeeklySchedules;
}