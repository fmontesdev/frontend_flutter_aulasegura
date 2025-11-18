import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/presentation/providers/time_slot_providers.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/domain/entities/time_slot.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_overlay_scaffold.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_table_calendar.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_timeslot_pill.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_slider_selector.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_button.dart';
import 'package:frontend_flutter_aulasegura/core/l10n/app_localizations.dart';

class CreateReservationPage extends ConsumerWidget {
  const CreateReservationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final text   = theme.textTheme;
    final l10n = AppLocalizations.of(context)!;

    // Escucha los cambios en las franjas horarias
    final timeSlotAsync = ref.watch(timeSlotProvider);

    return AppOverlayScaffold(
      title: l10n.requestReservation, //? Título de la página "Solicitar reserva" con internacionalización
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            /// Calendario
            AppTableCalendar(
              onDaySelected: (selectedDay) {
                // Lógica al seleccionar un día
              },
            ),
            const SizedBox(height: 14),

            /// Título “Horario” con icono
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.schedule, color: scheme.titles),
                          const SizedBox(width: 8),
                          Text(
                            l10n.schedule, //? Título "Horario" con internacionalización
                            style: text.titleLarge?.copyWith(
                              color: scheme.titles,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.compare_arrows, color: scheme.titles),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 9),

            timeSlotAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error cargando franjas horarias: $error')),
              data: (timeSlots) {
                /// Selector de franjas horarias
                return AppSliderSelector<TimeSlot>(
                  items: timeSlots,
                  selectionMode: SelectionMode.range, // single | multi | range
                  height: 74,
                  spacing: 8,
                  itemBuilder: (context, slot, isSelected, onTap) {
                    return AppTimeSlotPill(
                      variant: AppTSPillVariant.secondary,
                      size: AppTSPillSize.md,
                      timeSlot: slot,
                      isSelected: isSelected,
                      onTap: onTap,
                    );
                  },
                  onSelectionChanged: (index) {
                    debugPrint('Seleccionados: $index');
                  },
                );
              },
            ),
            const SizedBox(height: 12),

            /// Info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    l10n.slideToSeeMoreSchedules, //? Mensaje "Desliza para ver más horarios" con internacionalización
                    style: text.bodyMedium?.copyWith(
                    color: scheme.grey,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.east_outlined, color: scheme.grey, size: 14),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // // Título “Aula” con icono
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 22),
            //   child: Align(
            //     alignment: Alignment.centerLeft,
            //     child: Row(
            //       children: [
            //         Expanded(
            //           child: Row(
            //             children: [
            //               Icon(Icons.location_on_outlined, color: scheme.titles),
            //               const SizedBox(width: 8),
            //               Text(
            //                 'Aula',
            //                 style: text.titleMedium?.copyWith(
            //                   color: scheme.titles,
            //                   fontWeight: FontWeight.w500,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //         Icon(Icons.compare_arrows, color: scheme.titles),
            //       ],
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 8),

            // // Selector de aulas
            // AppSliderSelector<String>(
            //   items: rooms,
            //   selectionMode: SelectionMode.single, // single | multi | range
            //   height: 48,
            //   spacing: 9,
            //   itemBuilder: (context, label, isSelected, onTap) {
            //     return AppPill(
            //       variant: AppPillVariant.secondary,
            //       size: AppPillSize.md,
            //       label: label,
            //       icon: null,
            //       isSelected: isSelected,
            //       onTap: onTap,
            //     );
            //   },
            //   onSelectionChanged: (index) {
            //     debugPrint('Seleccionados: $index');
            //   },
            // ),

          ],
        ),
      ),
      bottomNavigationBar: SafeArea( // Evita solapamiento con barra de gestos
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: SizedBox(
            width: double.infinity, // Ancho completo
            child: AppButton(
              label: l10n.searchForAvailableClassrooms, //? Mensaje del botón "Buscar aulas disponibles" con internacionalización
              onPressed: () {},
              size: AppButtonSize.md,
              variant: AppButtonVariant.secondary,
            ),
          ),
        ),
      ),
    );
  }
}