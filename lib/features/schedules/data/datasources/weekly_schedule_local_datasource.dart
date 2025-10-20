// ignore_for_file: prefer_final_fields

import 'package:frontend_flutter_aulasegura/features/schedules/data/models/weekly_schedule_model.dart';

class WeeklyScheduleLocalDataSource {
  List<WeeklyScheduleModel> _weeklyScheduleList = [];

  // Constructor que recibe datos de horarios simulados
  WeeklyScheduleLocalDataSource({required List<Map<String, dynamic>> seed})
    : _weeklyScheduleList = seed.map(WeeklyScheduleModel.fromJson).toList();

  Future<List<WeeklyScheduleModel>> fetchByUserId(String userId) async {
    return _weeklyScheduleList.where((s) => s.userId == userId).toList();
  }
}