import 'package:frontend_flutter_aulasegura/features/notifications/domain/entities/notification.dart';

class NotificationModel extends Notification {
  const NotificationModel({
    required super.id,
    required super.type,
    required super.title,
    required super.body,
    required super.createdAt,
    required super.isRead,
    required super.userId,
  });

  @override
  NotificationModel copyWith({
    int? id,
    String? type,
    String? title,
    String? body,
    DateTime? createdAt,
    bool? isRead,
    String? userId,
  }) => NotificationModel(
    id: id ?? this.id,
    type: type ?? this.type,
    title: title ?? this.title,
    body: body ?? this.body,
    createdAt: createdAt ?? this.createdAt,
    isRead: isRead ?? this.isRead,
    userId: userId ?? this.userId,
  );

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    id: json['notification_id'] as int,
    type: json['type'] as String,
    title: json['title'] as String,
    body: json['body'] as String,
    createdAt: DateTime.parse(json['created_at'] as String),
    isRead: json['is_read'] as bool,
    userId: json['user_id'] as String,
  );

  Map<String, dynamic> toJson() => {
    'notification_id': id,
    'type': type,
    'title': title,
    'body': body,
    'created_at': createdAt.toIso8601String(),
    'is_read': isRead,
    'user_id': userId,
  };
}