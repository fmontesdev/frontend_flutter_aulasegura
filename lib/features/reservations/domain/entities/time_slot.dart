import 'package:equatable/equatable.dart';

class TimeSlot extends Equatable {
  final int id;
  final String startTime;
  final String endTime;

  const TimeSlot({
    required this.id,
    required this.startTime,
    required this.endTime,
  });

  TimeSlot copyWith({
    int? id,
    String? startTime,
    String? endTime,
  }) => TimeSlot(
    id: id ?? this.id,
    startTime: startTime ?? this.startTime,
    endTime: endTime ?? this.endTime,
  );

  @override
  List<Object?> get props => [
    id,
    startTime,
    endTime,
  ];
}