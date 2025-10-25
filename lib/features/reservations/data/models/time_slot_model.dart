import 'package:frontend_flutter_aulasegura/features/reservations/domain/entities/time_slot.dart';

class TimeSlotModel extends TimeSlot {
  const TimeSlotModel({
    required super.id,
    required super.startTime,
    required super.endTime,
  });

  @override
  TimeSlotModel copyWith({
    int? id,
    String? startTime,
    String? endTime,
  }) => TimeSlotModel(
    id: id ?? this.id,
    startTime: startTime ?? this.startTime,
    endTime: endTime ?? this.endTime,
  );

  factory TimeSlotModel.fromJson(Map<String, dynamic> json) => TimeSlotModel(
    id: json['timeslot_id'] as int,
    startTime: json['start_time'] as String,
    endTime: json['end_time'] as String,
  );

  Map<String, dynamic> toJson() => {
  'timeslot_id': id,
  'start_time': startTime,
  'end_time': endTime,
  };
}