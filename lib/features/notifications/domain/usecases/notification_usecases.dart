import 'package:frontend_flutter_aulasegura/features/notifications/domain/entities/notification.dart';
import 'package:frontend_flutter_aulasegura/features/notifications/domain/repositories/notification_repository.dart';

class NotificationUseCases {
  final Future<List<Notification>> Function(String userId) getNotificationsByUserId;

  NotificationUseCases(NotificationRepository repo)
    : getNotificationsByUserId = repo.getNotificationsByUserId;
}