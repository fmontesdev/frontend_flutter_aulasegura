import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_flutter_aulasegura/features/notifications/presentation/providers/notification_providers.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_filter_selector.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_list.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_notification_card.dart';

class NotificationsPage extends ConsumerStatefulWidget {
  const NotificationsPage({super.key});

  @override
  ConsumerState<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends ConsumerState<NotificationsPage> {
  int _selectedIndex = 0;

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
            // Filtro notificaciones pendientes/tipos/todas
            AppFilterSelector(
              options: const ['Pend.', 'Accesos', 'Avisos', 'Alertas', 'Todas'],
              selectedIndex: _selectedIndex,
              onChanged: (i) => setState(() => _selectedIndex = i),
            ),
            const SizedBox(height: 18),

            // Listado de notificaciones
            Expanded(
              child: notificationsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text('Error cargando notificaciones: $error')),
                data: (notifications) {
                  return AppList(
                    items: notifications.where((n) {
                      if (_selectedIndex == 0) return !n.isRead; // Pendientes
                      if (_selectedIndex == 1) return n.type == 'access'; // Accesos
                      if (_selectedIndex == 2) return n.type == 'alert'; // Avisos
                      if (_selectedIndex == 3) return n.type == 'warning'; // Alertas
                      if (_selectedIndex == 4) return true; // Todas
                      return false;
                    }).toList(),
                    itemBuilder: (item) => AppNotificationCard(
                      type: item.type,
                      title: item.title,
                      body: item.body,
                      date: item.createdAt,
                      isRead: item.isRead,
                    ),
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