import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_flutter_aulasegura/features/notifications/data/datasources/notification_local_datasource.dart';
import 'package:frontend_flutter_aulasegura/features/notifications/data/repositories/notification_repository_impl.dart';
import 'package:frontend_flutter_aulasegura/features/notifications/domain/repositories/notification_repository.dart';
import 'package:frontend_flutter_aulasegura/features/notifications/domain/usecases/notification_usecases.dart';
import 'package:frontend_flutter_aulasegura/features/notifications/domain/entities/notification.dart';
import 'package:frontend_flutter_aulasegura/fake_data/notifications_list.dart' as seed_data;
import 'package:frontend_flutter_aulasegura/features/auth/presentation/providers/auth_providers.dart';

/// DataSource con seed (fake_data)
final notificationLocalDataSourceProvider = Provider<NotificationLocalDataSource>((ref) {
  return NotificationLocalDataSource(seed: seed_data.notifications);
});

/// Repositorio
final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  final ds = ref.watch(notificationLocalDataSourceProvider);
  return NotificationRepositoryImpl(localDataSource: ds);
});

/// Casos de uso
final notificationUseCasesProvider = Provider<NotificationUseCases>((ref) {
  final repo = ref.watch(notificationRepositoryProvider);
  return NotificationUseCases(repo);
});

/// Notifier para manejar el estado de autenticación
class NotificationNotifier extends AsyncNotifier<List<Notification>> {
  /// Inicializa el Notifier
  @override
  Future<List<Notification>> build() async {
    // Obtiene el usuario autenticado
    final user = await ref.watch(authProvider.future);

    // Sin sesión no hay notificaciones
    if (user == null) {
      return <Notification>[];
    }

    // Carga inicial de notificaciones del usuario autenticado
    final notificationUseCases = ref.watch(notificationUseCasesProvider);
    return notificationUseCases.getNotificationsByUserId(user.id);
  }

  /// Marca una notificación como leída
  Future<void> markAsRead(int id) async {
    final prev = state;
    state = state.whenData((list) =>
        list.map((n) => n.id == id ? n.copyWith(isRead: true) : n).toList());

    try {
      final notificationUseCases = ref.read(notificationUseCasesProvider);
      await notificationUseCases.markAsRead(id);
    } catch (_) {
      state = prev; // rollback si fallara
    }
  }

  /// Marca una notificación como NO leída
  Future<void> markAsUnread(int id) async {
    final prev = state;
    state = state.whenData((list) =>
        list.map((n) => n.id == id ? n.copyWith(isRead: false) : n).toList());

    try {
      final notificationUseCases = ref.read(notificationUseCasesProvider);
      await notificationUseCases.markAsUnread(id);
    } catch (_) {
      state = prev; // rollback si fallara
    }
  }

  /// Marca todas las notificaciones como leídas
  Future<void> markAllAsRead() async {
    // Obtiene el usuario autenticado
    final user = await ref.watch(authProvider.future);
  
    // Sin sesión no hacemos nada
    if (user == null) {
      return;
    }

    final prev = state;
    state = state.whenData(
        (list) => list.map((n) => n.copyWith(isRead: true)).toList());

    try {
      final notificationUseCases = ref.read(notificationUseCasesProvider);
      await notificationUseCases.markAllAsRead(user.id);
    } catch (_) {
      state = prev; // rollback si fallara
    }
  }
}

final notificationProvider = AsyncNotifierProvider<NotificationNotifier, List<Notification>>(() {
  return NotificationNotifier();
});
