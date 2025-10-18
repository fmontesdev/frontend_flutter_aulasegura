import 'package:frontend_flutter_aulasegura/features/home/data/datasources/weekly_schedule_local_datasource.dart';
import 'package:frontend_flutter_aulasegura/features/home/domain/entities/weekly_schedule.dart';
import 'package:frontend_flutter_aulasegura/features/home/domain/repositories/weekly_schedule_repository.dart';

class WeeklyScheduleRepositoryImpl implements WeeklyScheduleRepository {
  final WeeklyScheduleLocalDataSource localDataSource;
  WeeklyScheduleRepositoryImpl({required this.localDataSource});

  @override
  Future<List<WeeklySchedule>> getWeeklySchedulesByUserId(String userId) async {
    final weeklySchedulesModel = await localDataSource.fetchByUserId(userId);
    return weeklySchedulesModel;
  }
}