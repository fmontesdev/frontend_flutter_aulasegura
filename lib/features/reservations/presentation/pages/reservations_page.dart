import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/presentation/providers/event_schedule_providers.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_filter_selector.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_list.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_reservation_card.dart';

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
    // // Marca la notificación como leída
    // _notifier.markAsRead(id);

    // // Muestra SnackBar con opción de deshacer
    // final messenger = ScaffoldMessenger.of(context);
    // messenger.removeCurrentSnackBar();
    // messenger.showSnackBar(
    //   SnackBar(
    //     content: const Padding(
    //       padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
    //       child: Text('Notificación marcada como leída'),
    //     ),
    //     backgroundColor: scheme.primary,
    //     behavior: SnackBarBehavior.floating,
    //     duration: const Duration(seconds: 3),
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(50),
    //     ),
    //     margin: const EdgeInsets.all(16),
    //     action: SnackBarAction(
    //       label: 'Deshacer',
    //       onPressed: () => _notifier.markAsUnread(id),
    //     ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final reservationsAsync = ref.watch(eventScheduleProvider);

    return Scaffold(
      backgroundColor: scheme.primaryContainer,
      body: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
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
                    options.add('Aprobadas');
                    predicates.add((r) => r.status == 'approved' && DateTime.parse(r.endAt).isAfter(DateTime.now()));
                  }
                  if (pendingCount > 0) {
                    options.add('Pendientes');
                    predicates.add((r) => r.status == 'pending' && DateTime.parse(r.endAt).isAfter(DateTime.now()));
                  }
                  if (revokedCount > 0) {
                    options.add('Canceladas');
                    predicates.add((r) => r.status == 'revoked' && DateTime.parse(r.endAt).isAfter(DateTime.now()));
                  }

                  // "Todas" SIEMPRE visible
                  // options.add('Todas');
                  // predicates.add((_) => true);

                  // Asegura índice válido si cambia el nº de opciones
                  final safeSelected = (_selectedIndex < options.length)
                      ? _selectedIndex
                      : options.length - 1;

                  // Lista filtrada con el predicado actual ordenada por fecha ascendente
                  final predicate = predicates[safeSelected];
                  final filtered = reservations.where(predicate).toList()
                    ..sort((a, b) => DateTime.parse(a.endAt).compareTo(DateTime.parse(b.endAt)));

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Selector de filtros dinámico
                      AppFilterSelector(
                        options: options,
                        selectedIndex: safeSelected,
                        onChanged: (i) => setState(() => _selectedIndex = i),
                      ),
                      const SizedBox(height: 18),

                      // Lista
                      Expanded(
                        child: AppList(
                          items: filtered,
                          itemBuilder: (item) => AppReservationCard(
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
    );
  }
}