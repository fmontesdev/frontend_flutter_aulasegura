// ignore_for_file: prefer_final_fields

import 'package:frontend_flutter_aulasegura/features/notifications/data/models/notification_model.dart';

class NotificationLocalDataSource {
  List<NotificationModel> _notificationList = [];

  // Constructor que recibe datos de notificaciones simuladas
  NotificationLocalDataSource({required List<Map<String, dynamic>> seed})
    : _notificationList = seed.map(NotificationModel.fromJson).toList();

  Future<List<NotificationModel>> fetchByUserId(String userId) async {
    return _notificationList.where((n) => n.userId == userId).toList();
  }
}