import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend_flutter_aulasegura/features/auth/presentation/pages/login_page.dart';
import 'package:frontend_flutter_aulasegura/features/auth/presentation/widgets/auth_gate.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_main_scaffold.dart';
import 'package:frontend_flutter_aulasegura/features/home/presentation/pages/home_page.dart';
import 'package:frontend_flutter_aulasegura/features/map/presentation/pages/map_page.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/presentation/pages/reservations_page.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/presentation/pages/create_reservation_page.dart';
import 'package:frontend_flutter_aulasegura/features/schedules/presentation/pages/schedules_page.dart';
import 'package:frontend_flutter_aulasegura/features/notifications/presentation/pages/notifications_page.dart';
import 'package:frontend_flutter_aulasegura/features/profile/presentation/pages/profile_page.dart';
import 'package:frontend_flutter_aulasegura/features/profile/presentation/pages/change_password_page.dart';
import 'package:frontend_flutter_aulasegura/features/access/presentation/pages/qr_scanner_page.dart';
import 'package:frontend_flutter_aulasegura/catalog/catalog_page.dart';
import 'package:frontend_flutter_aulasegura/core/utils/slide_from_right_page.dart';

// GlobalKeys para estados de navegación
final _rootNavigatorKey = GlobalKey<NavigatorState>(); // Clave global del router
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'homeNav'); // Clave para la rama "home"
final _shellNavigatorMapKey = GlobalKey<NavigatorState>(debugLabel: 'mapNav'); // Clave para la rama "map"
final _shellNavigatorResKey = GlobalKey<NavigatorState>(debugLabel: 'reservationNav'); // Clave para la rama "reservations"
final _shellNavigatorScheduleKey = GlobalKey<NavigatorState>(debugLabel: 'scheduleNav'); // Clave para la rama "schedule"
final _shellNavigatorNotiKey = GlobalKey<NavigatorState>(debugLabel: 'notificationNav'); // Clave para la rama "notification"

final router = GoRouter (
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      name: 'root',
      path: '/',
      builder: (context, state) => const AuthGate(),
    ),

    /// Rutas fullscreen fuera del ShellRoute
    GoRoute(
      name: 'login',
      path: '/login',
      parentNavigatorKey: _rootNavigatorKey, // Usamos el root navigator
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      name: 'profile',
      path: '/profile',
      parentNavigatorKey: _rootNavigatorKey, // Usamos el root navigator
      pageBuilder: (context, state) => slideFromRightPage(const ProfilePage(), state),
    ),
    GoRoute(
      name: 'change_password',
      path: '/change-password',
      parentNavigatorKey: _rootNavigatorKey, // Usamos el root navigator
      pageBuilder: (context, state) => slideFromRightPage(const ChangePasswordPage(), state),
    ),
    GoRoute(
      name: 'catalog',
      path: '/catalog',
      parentNavigatorKey: _rootNavigatorKey, // Usamos el root navigator
      pageBuilder: (context, state) => slideFromRightPage(const CatalogPage(), state),
    ),
    GoRoute(
      name: 'reservation_create',
      path: '/reservations/create',
      parentNavigatorKey: _rootNavigatorKey, // Usamos el root navigator
      pageBuilder: (context, state) => slideFromRightPage(const CreateReservationPage(), state),
    ),
    GoRoute(
      name: 'qr_scanner',
      path: '/qr-scanner',
      parentNavigatorKey: _rootNavigatorKey, // Usamos el root navigator
      builder: (context, state) => const QrScannerPage(),
    ),

    /// StatefulShellRoute añade estado de navegación interna a cada sección (rama/pestaña)
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppMainScaffold(
          navigationShell: navigationShell,
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