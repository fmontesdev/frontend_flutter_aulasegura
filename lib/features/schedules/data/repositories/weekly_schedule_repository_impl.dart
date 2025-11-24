import 'package:frontend_flutter_aulasegura/features/schedules/data/datasources/weekly_schedule_remote_datasource.dart';
import 'package:frontend_flutter_aulasegura/features/schedules/domain/repositories/weekly_schedule_repository.dart';
import 'package:frontend_flutter_aulasegura/features/access/domain/entities/permission.dart';


class WeeklyScheduleRepositoryImpl implements WeeklyScheduleRepository {
  final WeeklyScheduleRemoteDataSource remoteDataSource;
  WeeklyScheduleRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Permission>> getMyWeeklySchedules() async {
    final weeklySchedulesModel = await remoteDataSource.fetchMyWeeklySchedules();
    return weeklySchedulesModel;
  }
}