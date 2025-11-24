import 'package:equatable/equatable.dart';

class WeeklySchedule extends Equatable {
  final int dayOfWeek;
  final String startTime;
  final String endTime;

  const WeeklySchedule({
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
  });

  WeeklySchedule copyWith({
    int? dayOfWeek,
    String? startTime,
    String? endTime,
  }) => WeeklySchedule(
    dayOfWeek: dayOfWeek ?? this.dayOfWeek,
    startTime: startTime ?? this.startTime,
    endTime: endTime ?? this.endTime,
  );

  @override
  List<Object?> get props => [
    dayOfWeek,
    startTime,
    endTime,
  ];
}
