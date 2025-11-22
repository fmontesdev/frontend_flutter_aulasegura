import 'package:frontend_flutter_aulasegura/features/reservations/domain/entities/event_schedule.dart';

class EventScheduleModel extends EventSchedule {
  const EventScheduleModel({
    required super.eventType,
    required super.description,
    required super.startAt,
    required super.endAt,
    required super.status,
    super.reservationStatusReason,
  });

  @override
  EventScheduleModel copyWith({
    String? eventType,
    String? description,
    String? startAt,
    String? endAt,
    String? status,
    String? reservationStatusReason,
  }) => EventScheduleModel(
    eventType: eventType ?? this.eventType,
    description: description ?? this.description,
    startAt: startAt ?? this.startAt,
    endAt: endAt ?? this.endAt,
    status: status ?? this.status,
    reservationStatusReason: reservationStatusReason ?? this.reservationStatusReason,
  );

  factory EventScheduleModel.fromJson(Map<String, dynamic> json) => EventScheduleModel(
    eventType: json['eventType'] as String,
    description: json['description'] as String,
    startAt: json['startAt'] as String,
    endAt: json['endAt'] as String,
    status: json['status'] as String,
    reservationStatusReason: json['reservationStatusReason'] == null
        ? null
        : json['reservationStatusReason'] as String,
  );

  Map<String, dynamic> toJson() => {
  'eventType': eventType,
  'description': description,
  'startAt': startAt,
  'endAt': endAt,
  'status': status,
  'reservationStatusReason': reservationStatusReason,
  };
}