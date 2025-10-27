import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend_flutter_aulasegura/features/auth/presentation/providers/auth_providers.dart';
import 'package:frontend_flutter_aulasegura/features/schedules/presentation/providers/weekly_schedule_providers.dart';
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
        padding: const EdgeInsets.only(top: 18, left: 18, right: 18),
        child: userAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error de sesión: $error')),
          data: (authUser) {
            if (authUser == null) {
              // Si no hay sesión, vuelve al login
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

                // Card de acceso al aula
                Material(
                  color: scheme.onSecondary,
                  elevation: 1.5,
                  shadowColor: scheme.onPrimaryContainer.withValues(alpha: 0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                    side: BorderSide(
                      color: scheme.grey.withValues(alpha: 0.2),
                      width: 0.6,
                    ),
                  ),

                  // Card botones NFC / QR
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Botón NFC
                        Column(
                          children: [
                            Text(
                              'Acceso por NFC',
                              style: text.bodyMedium?.copyWith(
                                color: scheme.grey,
                              ),
                            ),
                            const SizedBox(height: 5),
                            AppButton(
                              icon: Icons.nfc_rounded,
                              onPressed: () {},
                              size: AppButtonSize.xl,
                              variant: AppButtonVariant.secondary,
                              isCircular: true,
                            ),
                          ],
                        ),
                        // Botón QR
                        Column(
                          children: [
                            Text(
                              'Acceso por QR',
                              style: text.bodyMedium?.copyWith(
                                color: scheme.grey,
                              ),
                            ),
                            const SizedBox(height: 5),
                            AppButton(
                              icon: Icons.qr_code,
                              onPressed: () {},
                              size: AppButtonSize.xl,
                              variant: AppButtonVariant.secondary,
                              isCircular: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 11),

                // Título “Hoy”
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Hoy',
                      style: text.titleLarge?.copyWith(
                        color: scheme.titles,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 11),

                // Horarios
                Expanded(
                  child: weeklySchedulesAsync.when(
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (error, stack) => Center(child: Text('Error cargando horarios: $error')),
                    data: (weeklySchedules) {
                      return AppList(
                        type: 'schedules',
                        items: weeklySchedules.where((s) => s.dayOfWeek == dayOfTheWeek()).toList(),
                        itemBuilder: (item) => AppScheduleCard(
                          classroom: '${item.room.name} ${item.room.roomCode}',
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