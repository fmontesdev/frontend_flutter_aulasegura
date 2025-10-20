import 'package:frontend_flutter_aulasegura/features/notifications/data/datasources/notification_local_datasource.dart';
import 'package:frontend_flutter_aulasegura/features/notifications/domain/entities/notification.dart';
import 'package:frontend_flutter_aulasegura/features/notifications/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationLocalDataSource localDataSource;
  NotificationRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Notification>> getNotificationsByUserId(String userId) async {
    final notificationsModel = await localDataSource.fetchByUserId(userId);
    return notificationsModel;
  }

  @override
  Future<void> markAsRead(int id) => localDataSource.markAsRead(id);

  @override
  Future<void> markAsUnread(int id) => localDataSource.markAsUnread(id);

  @override
  Future<void> markAllAsRead(String userId) => localDataSource.markAllAsRead(userId);
}