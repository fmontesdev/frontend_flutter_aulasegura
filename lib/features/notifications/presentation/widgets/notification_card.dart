import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';
import 'package:frontend_flutter_aulasegura/core/utils/date_formatter.dart';
import 'package:frontend_flutter_aulasegura/l10n/app_localizations.dart';

class NotificationCard extends ConsumerStatefulWidget {
  final int id;
  final String type;
  final String title;
  final String body;
  final DateTime date;
  final bool isRead;
  final VoidCallback onMarkRead; // Callback cuando la notificación se marca como leída

  const NotificationCard({
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
  ConsumerState<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends ConsumerState<NotificationCard> {
  bool _isHover = false; // Estado de hover para cambiar el borde

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

    // Altura y Colores de sombreado (tenue / hover)
    final Color baseShadow = scheme.onPrimaryContainer.withValues(alpha: 0.4);
    final Color hoverShadow = scheme.onPrimaryContainer.withValues(alpha: 0.6);
    final shadowColor = _isHover ? hoverShadow : baseShadow;

    final double baseElevation = 1.5;
    final double hoverElevation = 3.5;
    final elevation = _isHover ? hoverElevation : baseElevation;

    final l10n = AppLocalizations.of(context)!;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHover = true),
      onExit:  (_) => setState(() => _isHover = false),
      cursor: widget.isRead ? SystemMouseCursors.basic : SystemMouseCursors.click,
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
                    l10n.markAsRead, //? Mensaje para marcar como leída con internacionalización
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
            child: ColoredBox(
              color: backgroundColor,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 22, 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// Icono de notificación
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
                                /// Título
                                child: Text(
                                  widget.title,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    color: titleColor,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 2),
                              /// Fecha
                              Text(
                                dateTimeFormatter(context, widget.date),
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: dateColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          /// Cuerpo
                          Text(
                            widget.body,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: bodyColor,
                              height: 1.3,
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
      ),
    );
  }
}