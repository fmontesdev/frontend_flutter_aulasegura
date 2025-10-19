import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend_flutter_aulasegura/features/auth/presentation/pages/login_page.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_scaffold.dart';
import 'package:frontend_flutter_aulasegura/features/home/presentation/pages/home_page.dart';
import 'package:frontend_flutter_aulasegura/features/map/presentation/pages/map_page.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/presentation/pages/reservations_page.dart';
import 'package:frontend_flutter_aulasegura/features/schedules/presentation/pages/schedules_page.dart';
import 'package:frontend_flutter_aulasegura/features/notifications/presentation/pages/notifications_page.dart';

// GlobalKeys para estados de navegación
final _rootNavigatorKey = GlobalKey<NavigatorState>(); // Clave global del router
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'homeNav'); // Clave para la rama "home"
final _shellNavigatorMapKey = GlobalKey<NavigatorState>(debugLabel: 'mapNav'); // Clave para la rama "map"
final _shellNavigatorResKey = GlobalKey<NavigatorState>(debugLabel: 'reservationNav'); // Clave para la rama "reservations"
final _shellNavigatorScheduleKey = GlobalKey<NavigatorState>(debugLabel: 'scheduleNav'); // Clave para la rama "schedule"
final _shellNavigatorNotiKey = GlobalKey<NavigatorState>(debugLabel: 'notificationNav'); // Clave para la rama "notification"

typedef BoolGetter = bool Function();
typedef StringGetter = String Function();

class AppRouter {
  final BoolGetter getModoOscuro;
  final StringGetter getIdioma;
  final BoolGetter getNotificaciones;
  final ValueChanged<bool> onCambioModoOscuro;
  final ValueChanged<String> onCambioIdioma;
  final ValueChanged<bool> onCambioNotificaciones;

  late final GoRouter router;

  // 🔹 Constructor clásico al uso
  AppRouter({
    required this.getModoOscuro,
    required this.getIdioma,
    required this.getNotificaciones,
    required this.onCambioModoOscuro,
    required this.onCambioIdioma,
    required this.onCambioNotificaciones,
  }) {
    // Inicializamos el GoRouter dentro del constructor
    router = GoRouter (
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/login',
      routes: <RouteBase>[
        GoRoute(
          name: 'login',
          path: '/login',
          builder: (context, state) => const LoginPage(),
        ),

      // StatefulShellRoute añade estado de navegación interna a cada sección (rama/pestaña)
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppScaffold(
            navigationShell: navigationShell,
            modoOscuro: getModoOscuro(),
            idioma: getIdioma(),
            notificaciones: getNotificaciones(),
            onCambioIdioma: onCambioIdioma,
            onCambioModoOscuro: onCambioModoOscuro,
            onCambioNotificaciones: onCambioNotificaciones,
          );
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHomeKey,
            routes: [
              GoRoute(
                name: 'home',
                path: '/home',
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorMapKey,
            routes: [
              GoRoute(
                name: 'map',
                path: '/map',
                builder: (context, state) => const MapPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorResKey,
            routes: [
              GoRoute(
                name: 'reservations',
                path: '/reservations',
                builder: (context, state) => const ReservationsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorScheduleKey,
            routes: [
              GoRoute(
                name: 'schedules',
                path: '/schedules',
                builder: (context, state) => const SchedulesPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorNotiKey,
            routes: [
              GoRoute(
                name: 'notifications',
                path: '/notifications',
                builder: (context, state) => const NotificationsPage(),
              ),
            ],
          ),
        ],
      ),

        /// Ejemplo con params
        // GoRoute(
        //   path: '/fruits/:id',
        //   builder: (context, state) {
        //     final id = state.pathParameters["id"]! // Get "id" param from URL
        //     return FruitsPage(id: id);
        //   },
        // ),

        /// Ejemplo con rutas hijas
        // GoRoute(
        //   path: '/fruits',
        //   builder: (context, state) {
        //     return FruitsPage();
        //   },
        //   routes: <RouteBase>[ // Add child routes
        //     GoRoute(
        //       path: 'fruits-details', // NOTE: Don't need to specify "/" character for router’s parents
        //       builder: (context, state) {
        //         return FruitDetailsPage();
        //       },
        //     ),
        //   ],
        // )

      ],
    );
  }
}

