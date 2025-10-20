import 'package:frontend_flutter_aulasegura/features/schedules/domain/entities/weekly_schedule.dart';

abstract class WeeklyScheduleRepository {
  Future<List<WeeklySchedule>> getWeeklySchedulesByUserId(String userId);
}