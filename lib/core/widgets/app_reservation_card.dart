import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';
import 'package:frontend_flutter_aulasegura/core/utils/date_formatter.dart';
import 'package:frontend_flutter_aulasegura/features/schedules/domain/entities/room.dart';

class AppReservationCard extends ConsumerStatefulWidget {
  final int id;
  final String type;
  final String startAt;
  final String endAt;
  final String status;
  final String reason;
  final String createdAt;
  final Room room;
  final VoidCallback onDelete; // Callback cuando la reserva se elimina

  const AppReservationCard({
    super.key,
    required this.id,
    required this.type,
    required this.startAt,
    required this.endAt,
    required this.status,
    required this.reason,
    required this.createdAt,
    required this.room,
    required this.onDelete,
  });

  @override
  ConsumerState<AppReservationCard> createState() => _AppReservationCardState();
}

class _AppReservationCardState extends ConsumerState<AppReservationCard> {
  @override
  Widget build(BuildContext context) {
    final theme  = Theme.of(context);
    final scheme = theme.colorScheme;
    late final IconData icon;
    late final Color iconColor;

    switch (widget.status) {
      case 'pending':
        icon = Icons.hourglass_empty;
        iconColor = scheme.warning;
        break;
      case 'approved':
        icon = Icons.check_circle_outline;
        iconColor = scheme.success;
        break;
      case 'revoked':
        icon = Icons.cancel;
        iconColor = scheme.error;
        break;
      default:
        icon = Icons.help;
        iconColor = scheme.darkGrey;
    }

    return Material(
      color: Colors.transparent, // El color lo pinta el child (ColoredBox) para poder cambiar por isRead
      elevation: 2,
      shadowColor: scheme.onPrimaryContainer.withValues(alpha: 0.3),
      borderRadius: BorderRadius.circular(50),
      clipBehavior: Clip.antiAlias, // Para que el Dismissible no sobresalga

      // Swipe para marcar como leída (con Deshacer)
      child: Dismissible(
        key: ValueKey('res-${widget.id}'), // Clave única para cada reserva
        direction: DismissDirection.endToStart, // Dirección del swipe
        // No usamos start-to-end
        background: const SizedBox(),
        // Fondo del swipe end-to-start
        secondaryBackground: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          color: scheme.error.withValues(alpha: 0.75),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Eliminar',
                style: TextStyle(
                  color: scheme.onSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.delete, color: scheme.onSecondary),
            ],
          ),
        ),
        confirmDismiss: (_) async {
          widget.onDelete(); // Llama al callback externo
          return true; // Confirma el dismiss
        },

        // Contenido de la tarjeta
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: ColoredBox(
            color: scheme.onSecondary,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(9, 12, 20, 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Icono de estado de la reserva
                  Container(
                  alignment: Alignment.centerLeft, // Alineación a la izquierda
                  child: Icon(icon, color: iconColor, size: 30),
                  ),
                  const SizedBox(width: 9),

                  Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Alineación a la izquierda
                    children: [
                      Row(
                        children: [
                          // Fecha de reserva
                          const SizedBox(width: 2),
                          Icon(Icons.calendar_month, color: scheme.grey, size: 17),
                          const SizedBox(width: 6),
                          Text(
                            dateFormatter(DateTime.parse(widget.startAt)),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: scheme.grey,
                              // fontSize: 15,
                              fontWeight: FontWeight.w500,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            // Aula
                            child: Row(
                              children: [
                              Icon(Icons.school, color: scheme.secondary, size: 19),
                              const SizedBox(width: 6),
                              Text(
                                widget.room.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: scheme.secondary,
                                  fontSize: 17,
                                  height: 1.2,
                                ),
                              ),
                              ],
                            ),
                          ),
                          // const SizedBox(width: 6),

                          Row(
                            children: [
                              // Horas de reserva
                              Icon(Icons.access_time_filled, color: scheme.secondary, size: 17),
                              const SizedBox(width: 5),
                              Text(
                                timeReservation(DateTime.parse(widget.startAt), DateTime.parse(widget.endAt)),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: scheme.secondary,
                                  fontSize: 17,
                                  height: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ]
                      ),
                      const SizedBox(height: 8),

                      // Descripción
                      Text(
                        widget.reason,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: scheme.darkGrey,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
