import 'package:frontend_flutter_aulasegura/features/schedules/domain/entities/weekly_schedule.dart';
import 'package:frontend_flutter_aulasegura/features/schedules/domain/repositories/weekly_schedule_repository.dart';

class WeeklyScheduleUseCases {
  final Future<List<WeeklySchedule>> Function(String userId) getWeeklySchedulesByUserId;

  WeeklyScheduleUseCases(WeeklyScheduleRepository repo)
    : getWeeklySchedulesByUserId = repo.getWeeklySchedulesByUserId;
}