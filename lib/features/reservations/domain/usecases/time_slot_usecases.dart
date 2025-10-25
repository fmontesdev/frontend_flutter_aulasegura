import 'package:frontend_flutter_aulasegura/features/reservations/domain/entities/time_slot.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/domain/repositories/time_slot_repository.dart';

class TimeSlotUseCases {
  final Future<List<TimeSlot>> Function() getTimeSlots;

  TimeSlotUseCases(TimeSlotRepository repo)
    : getTimeSlots = repo.getTimeSlots;
}