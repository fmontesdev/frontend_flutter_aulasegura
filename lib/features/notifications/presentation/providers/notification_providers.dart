import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_flutter_aulasegura/features/notifications/data/datasources/notification_local_datasource.dart';
import 'package:frontend_flutter_aulasegura/features/notifications/data/repositories/notification_repository_impl.dart';
import 'package:frontend_flutter_aulasegura/features/notifications/domain/repositories/notification_repository.dart';
import 'package:frontend_flutter_aulasegura/features/notifications/domain/usecases/notification_usecases.dart';
import 'package:frontend_flutter_aulasegura/features/notifications/domain/entities/notification.dart';
import 'package:frontend_flutter_aulasegura/fake_data/notifications_list.dart' as seed_data;

import 'package:frontend_flutter_aulasegura/features/auth/presentation/providers/auth_providers.dart';

// DataSource con seed (fake_data)
final notificationLocalDataSourceProvider = Provider<NotificationLocalDataSource>((ref) {
  return NotificationLocalDataSource(seed: seed_data.notifications);
});

// Repositorio
final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  final ds = ref.watch(notificationLocalDataSourceProvider);
  return NotificationRepositoryImpl(localDataSource: ds);
});

// Casos de uso
final notificationUseCasesProvider = Provider<NotificationUseCases>((ref) {
  final repo = ref.watch(notificationRepositoryProvider);
  return NotificationUseCases(repo);
});

// Notifier para manejar el estado de autenticación
class NotificationNotifier extends AsyncNotifier<List<Notification>> {
  late final NotificationUseCases notificationUseCases;

  @override
  Future<List<Notification>> build() async {
    notificationUseCases = ref.watch(notificationUseCasesProvider);
    // Obtiene el usuario autenticado
    final user = await ref.watch(authProvider.future);
    if (user == null) {
      // Sin sesión → no hay notificaciones
      return <Notification>[];
    }
    // Carga inicial de notificaciones del usuario autenticado
    return notificationUseCases.getNotificationsByUserId(user.id);
  }
}

final notificationProvider = AsyncNotifierProvider<NotificationNotifier, List<Notification>>(() {
  return NotificationNotifier();
});
