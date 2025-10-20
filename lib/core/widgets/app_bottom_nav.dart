import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/presentation/providers/event_schedule_providers.dart';
import 'package:frontend_flutter_aulasegura/features/notifications/presentation/providers/notification_providers.dart';

class AppBottomNav extends ConsumerStatefulWidget {
  final StatefulNavigationShell navigationShell;
  final bool isOverlayPage;
  final ValueChanged<String>? onChanged;
  
  const AppBottomNav({
    super.key,
    required this.navigationShell,
    this.isOverlayPage = false,
    this.onChanged
  });

  @override
  ConsumerState<AppBottomNav> createState() => _AppBottomNavState();
}

class _AppBottomNavState extends ConsumerState<AppBottomNav> {
  void _onTap(int index) {
    final isReselect = index == widget.navigationShell.currentIndex;
    widget.navigationShell.goBranch(
      index,
      initialLocation: isReselect, // Si es reselect, se resetea la pila de navegación interna
    );
    widget.onChanged?.call(['Inicio', 'Mapa', 'Reservas', 'Horarios', 'Notificaciones'][index]); // Actualiza título en AppScaffold
  }
  
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    // Obtiene el número de notificaciones no leídas
    final notificationsAsync = ref.watch(notificationProvider);
    final unreadCount = notificationsAsync.maybeWhen(
      data: (notifications) => notifications.where((n) => !n.isRead).length,
      orElse: () => 0,
    );

    // Obtiene el número de reservas activas aprobadas
    final reservationsAsync = ref.watch(eventScheduleProvider);
    final countReservations = reservationsAsync.maybeWhen(
      data: (reservations) => reservations
        .where((r) => r.status == 'approved' && DateTime.parse(r.endAt).isAfter(DateTime.now()))
        .length,
      orElse: () => 0,
    );

    final backgroundColor = scheme.warning;
    final badgeTextNotis = unreadCount > 9 ? '9+' : unreadCount.toString();
    final badgeTextRes = countReservations > 9 ? '9+' : countReservations.toString();

    final destinations = [
      const NavigationDestination(
        icon: Icon(Icons.home_outlined),
        selectedIcon: Icon(Icons.home),
        label: 'Inicio'
      ),
      const NavigationDestination(
        icon: Icon(Icons.map_outlined),
        selectedIcon: Icon(Icons.map),
        label: 'Mapa'
      ),
      NavigationDestination(
        icon: Badge(
          backgroundColor: backgroundColor,
          isLabelVisible: countReservations > 0,
          label: Text(badgeTextRes),
          child: const Icon(Icons.add_circle_outline_outlined),
        ),
        selectedIcon: Badge(
          backgroundColor: backgroundColor,
          isLabelVisible: countReservations > 0,
          label: Text(badgeTextRes),
          child: const Icon(Icons.add_circle),
        ),
        label: 'Reservas'
      ),
      const NavigationDestination(
        icon: Icon(Icons.access_time),
        selectedIcon: Icon(Icons.access_time_filled),
        label: 'Horarios'
      ),
      NavigationDestination(
        icon: Badge(
          backgroundColor: backgroundColor,
          isLabelVisible: unreadCount > 0,
          label: Text(badgeTextNotis),
          child: const Icon(Icons.notifications_none),
        ),
        selectedIcon: Badge(
          backgroundColor: backgroundColor,
          isLabelVisible: unreadCount > 0,
          label: Text(badgeTextNotis),
          child: const Icon(Icons.notifications),
        ),
        label: 'Notificaciones'
      ),
    ];

    return NavigationBar(
      selectedIndex: widget.navigationShell.currentIndex,
      onDestinationSelected: _onTap,
      destinations: destinations,
    );
  }
}
