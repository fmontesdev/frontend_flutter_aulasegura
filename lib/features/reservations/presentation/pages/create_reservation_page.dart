import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/presentation/providers/time_slot_providers.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/presentation/providers/room_providers.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/presentation/providers/event_schedule_providers.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/domain/entities/time_slot.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/presentation/widgets/room_selectable_tile.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/presentation/widgets/room_card.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/domain/entities/room.dart';
import 'package:frontend_flutter_aulasegura/features/auth/presentation/providers/auth_providers.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_overlay_scaffold.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_table_calendar.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_timeslot_pill.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_slider_selector.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_button.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_section_title.dart';
import 'package:frontend_flutter_aulasegura/core/l10n/app_localizations.dart';
import 'package:frontend_flutter_aulasegura/core/utils/date_formatter.dart';
import 'package:frontend_flutter_aulasegura/core/utils/floating_snackbar.dart';

class CreateReservationPage extends ConsumerStatefulWidget {
  const CreateReservationPage({super.key});

  @override
  ConsumerState<CreateReservationPage> createState() => _CreateReservationPageState();
}

class _CreateReservationPageState extends ConsumerState<CreateReservationPage> {
  DateTime? _selectedDay;
  List<int> _selectedTimeSlotIndexes = [];
  String _startTime = '';
  String _endTime = '';
  Room? _selectedRoom;

  late final AppLocalizations l10n;

  @override
  // 
  void didChangeDependencies() {
    super.didChangeDependencies();
    l10n = AppLocalizations.of(context)!;
  }

  Future<void> _createReservation() async {
    if (_selectedDay == null || _selectedTimeSlotIndexes.isEmpty || _selectedRoom == null) return;

    final user = await ref.read(authProvider.future);
    if (user == null) {
      if (!mounted) return;
      showFloatingSnackBar(context, message: l10n.userNotAuthenticated);
      return;
    }
    
    // Construir DateTime completos
    final startAtDateTime = DateTime.parse('${dateToYYYYMMDD(_selectedDay!)} $_startTime');
    final endAtDateTime = DateTime.parse('${dateToYYYYMMDD(_selectedDay!)} $_endTime');

    try {
      await ref.read(eventScheduleProvider.notifier).createReservation(
            user.id,
            _selectedRoom!.id,
            l10n.classroomReservation,
            startAtDateTime,
            endAtDateTime,
          );

      if (!mounted) return;
      showFloatingSnackBar(context, message: l10n.reservationCreatedSuccessfully);
      
      // Volver a la página de reservas con filtro de pendientes
      context.go('/reservations', extra: {'initialFilter': l10n.reservationSelectorOption('pending')});
    } catch (error) {
      if (!mounted) return;
      showFloatingSnackBar(
        context,
        message: '${l10n.errorCreatingReservation}: $error',
        isError: true,
        duration: const Duration(seconds: 4),
      );
    }
  }

  void _showAvailableRoomsSheet() async {
    final timeSlots = await ref.read(timeSlotProvider.future);
    if (!mounted) return;

    // Validar que haya selección de fecha
    if (_selectedDay == null) {
      showFloatingSnackBar(context, message: l10n.pleaseSelectDate);
      return;
    }

    // Validar que haya selección de franjas horarias
    if (_selectedTimeSlotIndexes.isEmpty) {
      showFloatingSnackBar(context, message: l10n.pleaseSelectSchedule);
      return;
    }

    // Obtener primer y último TimeSlot seleccionado
    final firstIndex = _selectedTimeSlotIndexes.first;
    final lastIndex = _selectedTimeSlotIndexes.last;

    _startTime = timeSlots[firstIndex].startTime;
    _endTime = timeSlots[lastIndex].endTime;

    try {
      // Obtener aulas disponibles
      final rooms = await ref.read(roomProvider.notifier).getAvailableRooms(
        dateToYYYYMMDD(_selectedDay!),
        formatTimeToHHmm(_startTime),
        formatTimeToHHmm(_endTime)
      );

      if (!mounted) return;
      if (rooms.isEmpty) {
        showFloatingSnackBar(context, message: l10n.noAvailableClassrooms);
        return;
      }

      // Mostrar modal con aulas disponibles
      showModalBottomSheet<Room?>(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7, // Máximo % de la altura de la pantalla
        ),
        builder: (context) {
          return SafeArea(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 16),
              shrinkWrap: true, // Ajusta el tamaño al contenido (de lo contrario ocupa toda la pantalla)
              itemCount: rooms.length,
              itemBuilder: (context, index) {
                final room = rooms[index];
                return RoomSelectableTile(
                  room: room,
                  selected: _selectedRoom?.id == room.id,
                  onTap: () {
                    setState(() {
                      _selectedRoom = room;
                    });
                    context.pop();
                  },
                );
              },
            ),
          );
        },
      );
    } catch (error) {
      if (!mounted) return;
      showFloatingSnackBar(
        context,
        message: '${l10n.errorTitle}: $error',
        isError: true,
        duration: const Duration(seconds: 4),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Escucha los cambios en las franjas horarias
    final timeSlotAsync = ref.watch(timeSlotProvider);

    return AppOverlayScaffold(
      title: l10n.requestReservation, //? Título de la página "Solicitar reserva" con internacionalización
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [

            /// "Fecha" Título con icono
            AppSectionTitle(
              icon: Icons.calendar_month,
              title: l10n.date,
            ),
            const SizedBox(height: 9),

            /// Calendario
            AppTableCalendar(
              onDaySelected: (selectedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _selectedRoom = null; // Reset aula al cambiar fecha
                });
              },
            ),
            const SizedBox(height: 14),

            /// “Horario” Título con icono
            AppSectionTitle(
              icon: Icons.schedule,
              title: l10n.schedule, //? Título "Horario" con internacionalización
              trailingIcon: Icons.compare_arrows,
            ),
            const SizedBox(height: 9),

            timeSlotAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('${AppLocalizations.of(context)!.errorLoadingTimeSlots}: $error')),
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
                  onSelectionChanged: (indexes) {
                    setState(() {
                      _selectedTimeSlotIndexes = indexes;
                      _selectedRoom = null; // Reset aula al cambiar horario
                    });
                  },
                );
              },
            ),
            const SizedBox(height: 12),

            if (_selectedRoom != null) ...[

              /// "Aula" Título con icono
              AppSectionTitle(
                icon: Icons.location_on_outlined,
                title: l10n.room,
              ),
              const SizedBox(height: 12),

              /// Aula seleccionada
              RoomCard(
                room: _selectedRoom!,
                onTap: _showAvailableRoomsSheet,
              ),
              const SizedBox(height: 12),
            ],
          ],
        ),
      ),

      /// Botón inferior
      bottomNavigationBar: SafeArea( // Evita solapamiento con barra de gestos
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: SizedBox(
            width: double.infinity, // Ancho completo
            child: _selectedRoom == null
                ? AppButton(
                    label: l10n.searchForAvailableClassrooms, //? Mensaje del botón "Buscar aulas disponibles" con internacionalización
                    onPressed: _showAvailableRoomsSheet,
                    size: AppButtonSize.md,
                    variant: AppButtonVariant.secondary,
                  )
                : AppButton(
                    label: l10n.requestReservation, //? Mensaje del botón "Solicitar reserva" con internacionalización
                    onPressed: _createReservation,
                    size: AppButtonSize.md,
                    variant: AppButtonVariant.secondary,
                  ),
          ),
        ),
      ),
    );
  }
}