import 'package:frontend_flutter_aulasegura/features/notifications/domain/entities/notification.dart';
import 'package:frontend_flutter_aulasegura/features/notifications/domain/repositories/notification_repository.dart';

class NotificationUseCases {
  final Future<List<Notification>> Function(String userId) getNotificationsByUserId;
  final Future<void> Function(int id) markAsRead;
  final Future<void> Function(int id) markAsUnread;
  final Future<void> Function(String userId) markAllAsRead;

  NotificationUseCases(NotificationRepository repo)
    : getNotificationsByUserId = repo.getNotificationsByUserId,
      markAsRead = repo.markAsRead,
      markAsUnread = repo.markAsUnread,
      markAllAsRead = repo.markAllAsRead;
}