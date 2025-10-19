import 'package:equatable/equatable.dart';

class Notification extends Equatable {
  final int id;
  final String type;
  final String title;
  final String body;
  final DateTime createdAt;
  final bool isRead;
  final String userId;

  const Notification({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.isRead,
    required this.userId,
  });

  Notification copyWith({
    int? id,
    String? type,
    String? title,
    String? body,
    DateTime? createdAt,
    bool? isRead,
    String? userId,
  }) => Notification(
    id: id ?? this.id,
    type: type ?? this.type,
    title: title ?? this.title,
    body: body ?? this.body,
    createdAt: createdAt ?? this.createdAt,
    isRead: isRead ?? this.isRead,
    userId: userId ?? this.userId,
  );

  @override
  List<Object?> get props => [id, type, title, body, createdAt, isRead, userId];
}