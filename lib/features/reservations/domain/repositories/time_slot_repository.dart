import 'package:frontend_flutter_aulasegura/features/reservations/domain/entities/time_slot.dart';

abstract class TimeSlotRepository {
  Future<List<TimeSlot>> getTimeSlots();
}