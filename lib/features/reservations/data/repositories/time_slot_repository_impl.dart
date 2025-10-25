import 'package:frontend_flutter_aulasegura/features/reservations/data/datasources/time_slot_local_datasource.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/domain/entities/time_slot.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/domain/repositories/time_slot_repository.dart';

class TimeSlotRepositoryImpl implements TimeSlotRepository {
  final TimeSlotLocalDataSource localDataSource;
  TimeSlotRepositoryImpl({required this.localDataSource});

  @override
  Future<List<TimeSlot>> getTimeSlots() async {
    final timeSlotsModel = await localDataSource.fetchAll();
    return timeSlotsModel;
  }
}