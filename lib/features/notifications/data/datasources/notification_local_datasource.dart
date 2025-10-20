import 'package:frontend_flutter_aulasegura/features/notifications/data/models/notification_model.dart';

class NotificationLocalDataSource {
  List<NotificationModel> _notificationList = [];

  /// Constructor que recibe datos de notificaciones simuladas
  NotificationLocalDataSource({required List<Map<String, dynamic>> seed})
    : _notificationList = seed.map(NotificationModel.fromJson).toList();

  Future<List<NotificationModel>> fetchByUserId(String userId) async {
    return _notificationList.where((n) => n.userId == userId).toList();
  }

  /// Marca una notificación como leída
  Future<void> markAsRead(int id) async {
    _notificationList = _notificationList
        .map((n) => n.id == id ? n.copyWith(isRead: true) : n)
        .toList();
  }

  /// Marca una notificación como NO leída
  Future<void> markAsUnread(int id) async {
    _notificationList = _notificationList
        .map((n) => n.id == id ? n.copyWith(isRead: false) : n)
        .toList();
  }

  /// Marca todas las notificaciones como leídas para el usuario autenticado
  Future<void> markAllAsRead(String userId) async {
    _notificationList = _notificationList
        .map((n) => n.userId == userId ? n.copyWith(isRead: true) : n)
        .toList();
  }
}