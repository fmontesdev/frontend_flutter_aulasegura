import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend_flutter_aulasegura/features/auth/presentation/providers/auth_providers.dart';
import 'package:frontend_flutter_aulasegura/features/profile/presentation/providers/preferences_providers.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_overlay_scaffold.dart';
import 'package:frontend_flutter_aulasegura/l10n/app_localizations.dart';
import 'package:frontend_flutter_aulasegura/features/profile/presentation/widgets/user_card.dart';
import 'package:frontend_flutter_aulasegura/features/profile/presentation/widgets/security_card.dart';
import 'package:frontend_flutter_aulasegura/features/profile/presentation/widgets/preferences_card.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key,});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final userAsync = ref.watch(authProvider);
    final prefsAsync = ref.watch(preferencesProvider);
    final notifier = ref.read(preferencesProvider.notifier);

    final darkMode = prefsAsync.maybeWhen(
      data: (prefs) => prefs.darkMode,
      orElse: () => false,
    );
    final language = prefsAsync.maybeWhen(
      data: (prefs) => prefs.language,
      orElse: () => 'es',
    );
    final notifications = prefsAsync.maybeWhen(
      data: (prefs) => prefs.notifications,
      orElse: () => false,
    );

    return AppOverlayScaffold(
      title: l10n.profile,
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: ListView(
          children: [
            userAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text(l10n.sessionError(error))), //? Mensaje de error de sesión con internacionalización
              data: (authUser) {
                if (authUser == null) {
                  // Si no hay sesión, vuelve al login
                  Future.microtask(() {
                    if (context.mounted) GoRouter.of(context).go('/login');
                  });
                  return const SizedBox.shrink();
                }

                /// Card usuario
                return UserCard(user: authUser);
              },
            ),
            const SizedBox(height: 18), // Espaciado

            /// Card de Seguridad
            const SecurityCard(),

            const SizedBox(height: 18), // Espaciado

            /// Card de Preferencias
            PreferencesCard(
              darkMode: darkMode!,
              language: language!,
              notifications: notifications!,
              onToggleDarkMode: (d) => notifier.updateDarkMode(d),
              onChangeLanguage: (l) => notifier.updateLanguage(l),
              onToggleNotifications: (n) => notifier.updateNotifications(n),
            ),
          ],
        ),
      ),
    );
  }
}