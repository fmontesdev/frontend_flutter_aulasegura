import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';
import 'package:frontend_flutter_aulasegura/core/utils/date_formatter.dart';

class AppNotificationCard extends ConsumerStatefulWidget {
  final int id;
  final String type;
  final String title;
  final String body;
  final DateTime date;
  final bool isRead;
  final VoidCallback onMarkRead; // Callback cuando la notificación se marca como leída

  const AppNotificationCard({
    super.key,
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.date,
    required this.isRead,
    required this.onMarkRead,
  });

  @override
  ConsumerState<AppNotificationCard> createState() => _AppNotificationCardState();
}

class _AppNotificationCardState extends ConsumerState<AppNotificationCard> {
  @override
  Widget build(BuildContext context) {
    final theme  = Theme.of(context);
    final scheme = theme.colorScheme;

    // Colores según estado de lectura
    final backgroundColor = widget.isRead
        ? scheme.surface // color atenuado
        : scheme.onSecondary; // color normal

    final titleColor = widget.isRead
        ? scheme.grey.withValues(alpha: 0.7)
        : scheme.secondary;

    final dateColor = widget.isRead
        ? scheme.lightGrey.withValues(alpha: 0.7)
        : scheme.grey;

    final bodyColor = widget.isRead
        ? scheme.grey.withValues(alpha: 0.6)
        : scheme.onSurface;

    final iconColor = switch (widget.type) {
      'access' => widget.title.contains('aprobado')
          ? (widget.isRead ? scheme.grey.withValues(alpha: 0.7) : scheme.success)
          : (widget.isRead ? scheme.grey.withValues(alpha: 0.7) : scheme.warning),
      'warning' => widget.isRead ? scheme.grey.withValues(alpha: 0.7) : scheme.error,
      'alert' => widget.isRead ? scheme.grey.withValues(alpha: 0.7) : scheme.darkGrey,
      _ => widget.isRead ? scheme.grey.withValues(alpha: 0.7) : scheme.darkGrey,
    };

    return Material(
      color: Colors.transparent, // El color lo pinta el child (ColoredBox) para poder cambiar por isRead
      elevation: 2,
      shadowColor: scheme.onPrimaryContainer.withValues(alpha: 0.3),
      borderRadius: BorderRadius.circular(50),
      clipBehavior: Clip.antiAlias, // Para que el Dismissible no sobresalga

      // Swipe para marcar como leída (con Deshacer)
      child: Dismissible(
        key: ValueKey('notif-${widget.id}'), // Clave única para cada notificación
        direction: widget.isRead ? DismissDirection.none : DismissDirection.endToStart, // Dirección swipe solo si no está leída
        // No usamos start-to-end
        background: const SizedBox(),
        // Fondo del swipe end-to-start
        secondaryBackground: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          color: scheme.success.withValues(alpha: 0.75),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Marcar como leída',
                style: TextStyle(
                  color: scheme.onSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.check, color: scheme.onSecondary),
            ],
          ),
        ),
        confirmDismiss: (_) async {
          widget.onMarkRead(); // Llama al callback externo
          return true; // Confirma el dismiss
        },

        // Contenido de la tarjeta
        child: MouseRegion(
          cursor: widget.isRead ? SystemMouseCursors.basic : SystemMouseCursors.click,
          child: ColoredBox(
            color: backgroundColor,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(9, 12, 20, 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Icono de notificación
                  Container(
                    alignment: Alignment.center,
                    child: Icon(
                    switch (widget.type) {
                      'access' => widget.title.contains('aprobado')
                          ? Icons.lock_open
                          : Icons.lock_outline,
                      'warning' => Icons.warning_amber,
                      'alert' => Icons.error_outline,
                      _ => Icons.error_outline,
                    },
                    color: iconColor,
                    size: 30,
                    ),
                  ),
                  const SizedBox(width: 9),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              // Título
                              child: Text(
                                widget.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: titleColor,
                                  fontSize: 17,
                                  height: 1.2,
                                ),
                              ),
                            ),
                            const SizedBox(height: 2),
                            // Fecha
                            Text(
                              dateTimeFormatter(widget.date),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: dateColor,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        // Cuerpo
                        Text(
                          widget.body,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: bodyColor,
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
