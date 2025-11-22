import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';
import 'package:frontend_flutter_aulasegura/core/utils/date_formatter.dart';
import 'package:frontend_flutter_aulasegura/features/schedules/domain/entities/room.dart';
import 'package:frontend_flutter_aulasegura/core/l10n/app_localizations.dart';

class ReservationCard extends ConsumerStatefulWidget {
  final int id;
  final String type;
  final String startAt;
  final String endAt;
  final String status;
  final String description;
  final String createdAt;
  final Room room;
  final VoidCallback onDelete; // Callback cuando la reserva se elimina

  const ReservationCard({
    super.key,
    required this.id,
    required this.type,
    required this.startAt,
    required this.endAt,
    required this.status,
    required this.description,
    required this.createdAt,
    required this.room,
    required this.onDelete,
  });

  @override
  ConsumerState<ReservationCard> createState() => _ReservationCardState();
}

class _ReservationCardState extends ConsumerState<ReservationCard> {
  bool _isHover = false; // Estado de hover para cambiar el borde

  @override
  Widget build(BuildContext context) {
    final theme  = Theme.of(context);
    final scheme = theme.colorScheme;
    late final IconData icon;
    late final Color iconColor;

    // Altura y Colores de sombreado (tenue / hover)
    final Color baseShadow = scheme.onPrimaryContainer.withValues(alpha: 0.4);
    final Color hoverShadow = scheme.onPrimaryContainer.withValues(alpha: 0.6);
    final shadowColor = _isHover ? hoverShadow : baseShadow;

    final double baseElevation = 1.5;
    final double hoverElevation = 3.5;
    final elevation = _isHover ? hoverElevation : baseElevation;

    final l10n = AppLocalizations.of(context)!;

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
    return MouseRegion(
      onEnter: (_) => setState(() => _isHover = true),
      onExit:  (_) => setState(() => _isHover = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150), // Para animar suavemente el cambio del sombreado
        curve: Curves.easeInOut,
        child: Material(
          color: Colors.transparent, // El color lo pinta el child (ColoredBox) para poder cambiar por isRead
          elevation: elevation,
          shadowColor: shadowColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
            side: BorderSide(
              color: scheme.grey.withValues(alpha: 0.2),
              width: 0.6,
            ),
          ),
          clipBehavior: Clip.antiAlias, // Para que el Dismissible no sobresalga

          /// Swipe para marcar como leída (con Deshacer)
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
                    l10n.delete, //? Mensaje de eliminar con internacionalización
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
            child: ColoredBox(
              color: scheme.onSecondary,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 16, 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// Icono de estado de la reserva
                    Container(
                    alignment: Alignment.centerLeft, // Alineación a la izquierda
                    child: Icon(icon, color: iconColor, size: 30),
                    ),
                    const SizedBox(width: 8),

                    Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Alineación a la izquierda
                      children: [
                        Row(
                          children: [
                            /// Fecha de reserva
                            const SizedBox(width: 2),
                            Icon(Icons.calendar_today_outlined, color: scheme.grey, size: 17),
                            const SizedBox(width: 6),
                            Text(
                              dateFormatter(context, DateTime.parse(widget.startAt)),
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: scheme.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),

                        Row(
                          children: [
                            /// Aula
                            Icon(Icons.location_on_outlined, color: scheme.secondary, size: 19),
                            const SizedBox(width: 3),
                            Text(
                              '${widget.room.name} ${widget.room.roomCode}',
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: scheme.secondary,
                              ),
                            ),
                            const SizedBox(width: 14),

                            /// Horas de reserva
                            Icon(Icons.access_time, color: scheme.secondary, size: 19),
                            const SizedBox(width: 6),
                            Text(
                              timeReservation(DateTime.parse(widget.startAt), DateTime.parse(widget.endAt)),
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: scheme.secondary,
                              ),
                            ),
                          ]
                        ),
                        const SizedBox(height: 4),

                        Row(
                          children: [
                          /// Descripción
                            const SizedBox(width: 2),
                            Expanded(
                              child: Text(
                                widget.description,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: scheme.onSurface,
                                  height: 1.3,
                                ),
                              ),
                            ),
                          ],
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
      ),
    );
  }
}
