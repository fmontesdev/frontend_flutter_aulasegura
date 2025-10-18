import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend_flutter_aulasegura/features/auth/presentation/providers/auth_providers.dart';
import 'package:frontend_flutter_aulasegura/features/home/presentation/providers/weekly_schedule_providers.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_welcome_card.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_button.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_list.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_schedule_card.dart';
import 'package:frontend_flutter_aulasegura/core/utils/date_formatter.dart';
import 'package:frontend_flutter_aulasegura/core/utils/convert_role.dart';
import 'package:frontend_flutter_aulasegura/core/utils/day_of_the_week.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final text   = Theme.of(context).textTheme;

    final userAsync = ref.watch(authProvider);
    final weeklySchedulesAsync = ref.watch(weeklyScheduleProvider);

    return Scaffold(
      backgroundColor: scheme.primaryContainer,
      body: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        child: userAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error de sesión: $error')),
          data: (authUser) {
            if (authUser == null) {
              // No hay sesión → vuelve a login
              Future.microtask(() {
                if (context.mounted) GoRouter.of(context).go('/login');
              });
              return const SizedBox.shrink();
            }
              
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Card de bienvenida
                AppWelcomeCard(
                  date: dateFormatter(DateTime.now()),
                  name: authUser.name,
                  role: convertRole(authUser.role.name),
                  avatar: 'assets/images/${authUser.avatar}', //! Convertir a URL de la API
                ),
                const SizedBox(height: 18),

                // Título “Acceder al aula”
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Acceso',
                      textAlign: TextAlign.center,
                      style: text.titleLarge?.copyWith(
                        fontSize: 21,
                        color: scheme.titles,
                        height: 0.9,
                      ),
                    ),
                  ),
                ),
                // const SizedBox(height: 12),

                // Botones NFC + QR
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        icon: Icons.nfc_rounded,
                        onPressed: () {},
                        size: AppButtonSize.xl,
                        variant: AppButtonVariant.secondary,
                        isCircular: true,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: AppButton(
                        icon: Icons.qr_code,
                        onPressed: () {},
                        size: AppButtonSize.xl,
                        variant: AppButtonVariant.secondary,
                        isCircular: true,
                      ),
                    ),
                  ],
                ),
                // const SizedBox(height: 18),

                // Título “Hoy”
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Hoy',
                      textAlign: TextAlign.center,
                      style: text.titleLarge?.copyWith(
                        fontSize: 21,
                        color: scheme.titles,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Horarios
                Expanded(
                  child: weeklySchedulesAsync.when(
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (error, stack) => Center(child: Text('Error cargando horarios: $error')),
                    data: (weeklySchedules) {
                      return AppList(
                        items: weeklySchedules.where((s) => s.dayOfWeek == dayOfTheWeek()).toList(),
                        itemBuilder: (item) => AppScheduleCard(
                          classroom: item.room.name,
                          group: item.room.course?.name ?? 'Sin grupo',
                          timeRange: '${item.startTime} - ${item.endTime}',
                          subject: item.subject?.name ?? 'Sin asignatura',
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}