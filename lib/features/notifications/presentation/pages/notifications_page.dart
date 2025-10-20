import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_flutter_aulasegura/features/notifications/presentation/providers/notification_providers.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_filter_selector.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_list.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_notification_card.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_snackbar_button.dart';

class NotificationsPage extends ConsumerStatefulWidget {
  const NotificationsPage({super.key});

  @override
  ConsumerState<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends ConsumerState<NotificationsPage> {
  int _selectedIndex = 0;
  late final NotificationNotifier _notifier;

  @override
  void initState() {
    super.initState();
    _notifier = ref.read(notificationProvider.notifier); // Lee el notifier una vez y lo guarda en el estado
  }

  void _handleMarkRead(BuildContext context, int id, ColorScheme scheme) {
    // Marca la notificación como leída
    _notifier.markAsRead(id);

    // Muestra SnackBar con opción de deshacer
    final messenger = ScaffoldMessenger.of(context);
    messenger.removeCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: const Padding(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          child: Text('Notificación marcada como leída'),
        ),
        backgroundColor: scheme.primary,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        margin: const EdgeInsets.all(16),
        action: SnackBarAction(
          label: 'Deshacer',
          onPressed: () => _notifier.markAsUnread(id),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final notificationsAsync = ref.watch(notificationProvider);

    return Scaffold(
      backgroundColor: scheme.primaryContainer,
      body: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: notificationsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text('Error cargando notificaciones: $error')),
                data: (notifications) {
                  // Cálculos de disponibilidad por categoría
                  final pendingCount = notifications.where((n) => !n.isRead).length;
                  final accessCount  = notifications.where((n) => n.type == 'access'  && !n.isRead).length; // Accesos
                  final alertCount  = notifications.where((n) => n.type == 'alert'   && !n.isRead).length; // Avisos
                  final warningCount = notifications.where((n) => n.type == 'warning' && !n.isRead).length; // Alertas

                  // Construcción de opciones y predicados dinámicos para los filtros
                  final options = <String>[];
                  final predicates = <bool Function(dynamic)>[];

                  if (pendingCount > 0 && pendingCount <= 3) {
                    options.add('Pendientes');
                    predicates.add((n) => !n.isRead);
                  }
                  if (pendingCount > 3 && pendingCount <= 5) {
                    options.add('Pend.');
                    predicates.add((n) => !n.isRead);
                  }
                  if (accessCount > 0) {
                    options.add('Accesos');
                    predicates.add((n) => n.type == 'access' && !n.isRead);
                  }
                  if (alertCount > 0) {
                    options.add('Avisos');
                    predicates.add((n) => n.type == 'alert' && !n.isRead);
                  }
                  if (warningCount > 0) {
                    options.add('Alertas');
                    predicates.add((n) => n.type == 'warning' && !n.isRead);
                  }

                  // "Todas" SIEMPRE visible
                  options.add('Todas');
                  predicates.add((_) => true);

                  // Asegura índice válido si cambia el nº de opciones
                  final safeSelected = (_selectedIndex < options.length)
                      ? _selectedIndex
                      : options.length - 1;

                  // Lista filtrada con el predicado actual
                  final predicate = predicates[safeSelected];
                  final filtered = notifications.where(predicate).toList();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Selector de filtros dinámico
                      AppFilterSelector(
                        options: options,
                        selectedIndex: safeSelected,
                        onChanged: (i) => setState(() => _selectedIndex = i),
                      ),

                      // Botón "Marcar todas como leídas"
                      if (pendingCount > 0) ...[
                        const SizedBox(height: 10),
                        AppSnackBarButton(
                          variant: AppSnackBarButtonVariant.success,
                          size: AppSnackBarButtonSize.md,
                          icon: Icons.done_all,
                          label: 'Marcar todas como leídas ($pendingCount)',
                          onPressed: () => _notifier.markAllAsRead(),
                          snackBarMessage: 'Todas las notificaciones marcadas como leídas',
                        ),
                      ],
                      const SizedBox(height: 18),

                      // Lista
                      Expanded(
                        child: AppList(
                          items: filtered,
                          itemBuilder: (item) => AppNotificationCard(
                            id: item.id,
                            type: item.type,
                            title: item.title,
                            body: item.body,
                            date: item.createdAt,
                            isRead: item.isRead,
                            onMarkRead: () => _handleMarkRead(context, item.id, scheme), // Maneja marcar como leída
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}