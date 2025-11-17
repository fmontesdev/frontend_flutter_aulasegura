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

class ReservationsPage extends ConsumerStatefulWidget {
  const ReservationsPage({super.key});

  @override
  ConsumerState<ReservationsPage> createState() => _ReservationsPageState();
}

class _ReservationsPageState extends ConsumerState<ReservationsPage> {
  int _selectedIndex = 0;
  late final EventScheduleNotifier _notifier;

  @override
  void initState() {
    super.initState();
    _notifier = ref.read(eventScheduleProvider.notifier); // Lee el notifier una vez y lo guarda en el estado
  }

  void _handleDelete(BuildContext context, int id, ColorScheme scheme) {
    // Elimina la reserva
    _notifier.deleteById(id);

    // Muestra SnackBar con mensaje de confirmación
    final messenger = ScaffoldMessenger.of(context);
    messenger.removeCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: const Padding(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          child: Text(
            'Reserva eliminada',
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: scheme.primary,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        margin: const EdgeInsets.all(16),
      ),
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
                error: (error, stack) => Center(child: Text('Error cargando reservas: $error')),
                data: (reservations) {
                  // Cálculos de disponibilidad por categoría
                  final pendingCount = reservations.where((r) => r.status == 'pending').length; // Pendientes
                  final approvedCount  = reservations.where((r) => r.status == 'approved').length; // Aprobadas
                  final revokedCount  = reservations.where((r) => r.status == 'revoked').length; // Revocadas

                  // Construcción de opciones y predicados dinámicos para los filtros
                  final options = <String>[];
                  final predicates = <bool Function(dynamic)>[];

                  if (approvedCount > 0) {
                    options.add(l10n.reservationSelectorOption('approved'));
                    predicates.add((r) => r.status == 'approved' && DateTime.parse(r.endAt).isAfter(DateTime.now()));
                  }
                  if (pendingCount > 0) {
                    options.add(l10n.reservationSelectorOption('pending'));
                    predicates.add((r) => r.status == 'pending' && DateTime.parse(r.endAt).isAfter(DateTime.now()));
                  }
                  if (revokedCount > 0) {
                    options.add(l10n.reservationSelectorOption('revoked'));
                    predicates.add((r) => r.status == 'revoked' && DateTime.parse(r.endAt).isAfter(DateTime.now()));
                  }

                  // Asegura índice válido si cambia el nº de opciones
                  final safeSelected = (_selectedIndex < options.length)
                      ? _selectedIndex
                      : options.length - 1;

                  // Lista filtrada con el predicado actual ordenada por fecha ascendente
                  final predicate = predicates.isNotEmpty ? predicates[safeSelected] : (_) => false;
                  final filtered = reservations.where(predicate).toList()
                    ..sort((a, b) => DateTime.parse(a.endAt).compareTo(DateTime.parse(b.endAt)));

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
                          itemBuilder: (item) => ReservationCard(
                            id: item.id,
                            type: item.type,
                            startAt: item.startAt,
                            endAt: item.endAt,
                            status: item.status,
                            reason: item.reason,
                            createdAt: item.createdAt,
                            room: item.room,
                            onDelete: () => _handleDelete(context, item.id, scheme), // Maneja eliminar reserva
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