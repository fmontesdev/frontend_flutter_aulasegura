// ignore_for_file: prefer_final_fields

import 'package:frontend_flutter_aulasegura/features/reservations/data/models/time_slot_model.dart';

class TimeSlotLocalDataSource {
  List<TimeSlotModel> _timeSlotList = [];

  // Constructor que recibe datos de eventos simulados
  TimeSlotLocalDataSource({required List<Map<String, dynamic>> seed})
    : _timeSlotList = seed.map(TimeSlotModel.fromJson).toList();

  Future<List<TimeSlotModel>> fetchAll() async {
    return _timeSlotList.toList();
  }
}