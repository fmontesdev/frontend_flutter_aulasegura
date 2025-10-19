import 'package:frontend_flutter_aulasegura/features/notifications/domain/entities/notification.dart';

abstract class NotificationRepository {
  Future<List<Notification>> getNotificationsByUserId(String userId);
}