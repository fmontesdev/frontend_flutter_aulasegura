import 'package:equatable/equatable.dart';

class EventSchedule extends Equatable {
  final String eventType;
  final String description;
  final String startAt;
  final String endAt;
  final String status;
  final String? reservationStatusReason;

  const EventSchedule({
    required this.eventType,
    required this.description,
    required this.startAt,
    required this.endAt,
    required this.status,
    this.reservationStatusReason,
  });

  EventSchedule copyWith({
    String? eventType,
    String? description,
    String? startAt,
    String? endAt,
    String? status,
    String? reservationStatusReason,
  }) => EventSchedule(
    eventType: eventType ?? this.eventType,
    description: description ?? this.description,
    startAt: startAt ?? this.startAt,
    endAt: endAt ?? this.endAt,
    status: status ?? this.status,
    reservationStatusReason: reservationStatusReason ?? this.reservationStatusReason,
  );

  @override
  List<Object?> get props => [
    eventType,
    description,
    startAt,
    endAt,
    status,
    reservationStatusReason,
  ];
}
