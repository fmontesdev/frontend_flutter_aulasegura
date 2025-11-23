import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/presentation/providers/event_schedule_providers.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_filter_selector.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_list.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/presentation/widgets/reservation_card.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_fab.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_fab_hide_on_scroll.dart';
import 'package:frontend_flutter_aulasegura/core/l10n/app_localizations.dart';
import 'package:frontend_flutter_aulasegura/core/utils/floating_snackbar.dart';

class ReservationsPage extends ConsumerStatefulWidget {
  final String? initialFilter;
  
  const ReservationsPage({
    super.key,
    this.initialFilter
  });

  @override
  ConsumerState<ReservationsPage> createState() => _ReservationsPageState();
}

class _ReservationsPageState extends ConsumerState<ReservationsPage> {
  int _selectedIndex = 0;
  bool _initialFilterApplied = false;
  late final EventScheduleNotifier _notifier;

  @override
  void initState() {
    super.initState();
    _notifier = ref.read(eventScheduleProvider.notifier); // Lee el notifier una vez y lo guarda en el estado
  }

  void _handleDelete(BuildContext context, permission) {
    // Elimina la reserva
    _notifier.delete(permission.user.id, permission.room.id, permission.schedule.id);

    // Muestra SnackBar con mensaje de confirmación
    final l10n = AppLocalizations.of(context)!;
    showFloatingSnackBar(
      context,
      message: l10n.reservationDeleted,
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final reservationsAsync = ref.watch(eventScheduleProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: scheme.primaryContainer,
      body: Padding(
        padding: const EdgeInsets.only(top: 18, left: 18, right: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: reservationsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text('${l10n.errorLoadingReservations}: $error')),
                data: (reservations) {
                  // Cálculos de disponibilidad por categoría
                  final pendingCount = reservations.where((r) => r.schedule.eventSchedule!.status == 'pending').length; // Pendientes
                  final approvedCount  = reservations.where((r) => r.schedule.eventSchedule!.status == 'approved').length; // Aprobadas
                  final revokedCount  = reservations.where((r) => r.schedule.eventSchedule!.status == 'revoked').length; // Revocadas

                  // Construcción de opciones y predicados dinámicos para los filtros
                  final options = <String>[];
                  final predicates = <bool Function(dynamic)>[];

                  if (approvedCount > 0) {
                    options.add(l10n.reservationSelectorOption('approved'));
                    predicates.add((r) => r.schedule.eventSchedule!.status == 'approved' && DateTime.parse(r.schedule.eventSchedule!.endAt).isAfter(DateTime.now()));
                  }
                  if (pendingCount > 0) {
                    options.add(l10n.reservationSelectorOption('pending'));
                    predicates.add((r) => r.schedule.eventSchedule!.status == 'pending' && DateTime.parse(r.schedule.eventSchedule!.endAt).isAfter(DateTime.now()));
                  }
                  if (revokedCount > 0) {
                    options.add(l10n.reservationSelectorOption('revoked'));
                    predicates.add((r) => r.schedule.eventSchedule!.status == 'revoked' && DateTime.parse(r.schedule.eventSchedule!.endAt).isAfter(DateTime.now()));
                  }

                  // Establece el filtro en pendiente cuando se crea una nueva reserva
                  if (widget.initialFilter != null && !_initialFilterApplied) {
                    final filterIndex = options.indexOf(widget.initialFilter!);
                    if (filterIndex != -1) {
                      _selectedIndex = filterIndex;
                      _initialFilterApplied = true; // Controla que solo se aplique una vez
                    }
                  }

                  // Asegura índice válido si cambia el nº de opciones
                  final safeSelected = (_selectedIndex < options.length)
                      ? _selectedIndex
                      : options.length - 1;

                  // Lista filtrada con el predicado actual ordenada por fecha ascendente
                  final predicate = predicates.isNotEmpty ? predicates[safeSelected] : (_) => false;
                  final filtered = reservations.where(predicate).toList()
                    ..sort((a, b) => DateTime.parse(a.schedule.eventSchedule!.endAt).compareTo(DateTime.parse(b.schedule.eventSchedule!.endAt)));

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      /// Selector de filtros dinámico
                      AppFilterSelector(
                        options: options,
                        selectedIndex: safeSelected,
                        onChanged: (i) => setState(() => _selectedIndex = i),
                      ),
                      const SizedBox(height: 18),

                      /// Lista
                      Expanded(
                        child: AppList(
                          type: 'reservations',
                          items: filtered,
                          itemBuilder: (item) {
                            final eventSchedule = item.schedule.eventSchedule!;
                            return ReservationCard(
                              id: item.schedule.id,
                              type: eventSchedule.eventType,
                              startAt: eventSchedule.startAt,
                              endAt: eventSchedule.endAt,
                              status: eventSchedule.status,
                              description: eventSchedule.description,
                              createdAt: item.createdAt.toIso8601String(),
                              room: item.room,
                              onDelete: () => _handleDelete(context, item), // Maneja eliminar reserva
                            );
                          },
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: AppFabHideOnScroll(
        child: AppFab(
          variant: AppFabVariant.secondary,
          size: AppFabSize.md,
          icon: Icons.add,
          heroTag: 'reservations-fab',
          tooltip: l10n.requestReservation, //? Tooltip del botón de solicitar reserva con internacionalización
          onPressed: () {
            context.push('/reservations/create');
          },
        ),
      ),
    );
  }
}