import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';
import 'package:frontend_flutter_aulasegura/core/utils/date_formatter.dart';

class AppNotificationCard extends StatelessWidget {
  final String type;
  final String title;
  final String body;
  final DateTime date;
  final bool isRead;

  const AppNotificationCard({
    super.key,
    required this.type,
    required this.title,
    required this.body,
    required this.date,
    required this.isRead,
  });

  @override
  Widget build(BuildContext context) {
    final theme  = Theme.of(context);
    final scheme = theme.colorScheme;

    // Colores según estado de lectura
    final backgroundColor = isRead
        ? scheme.surface // color atenuado
        : scheme.onSecondary; // color normal

    final titleColor = isRead
        ? scheme.grey.withValues(alpha: 0.7)
        : scheme.secondary;

    final dateColor = isRead
        ? scheme.lightGrey.withValues(alpha: 0.7)
        : scheme.grey;

    final bodyColor = isRead
        ? scheme.grey.withValues(alpha: 0.6)
        : scheme.onSurface;

    final iconColor = switch (type) {
      'access' => title.contains('aprobado')
          ? (isRead ? scheme.grey.withValues(alpha: 0.7) : scheme.success)
          : (isRead ? scheme.grey.withValues(alpha: 0.7) : scheme.warning),
      'warning' => isRead ? scheme.grey.withValues(alpha: 0.7) : scheme.error,
      'alert' => isRead ? scheme.grey.withValues(alpha: 0.7) : scheme.darkGrey,
      _ => isRead ? scheme.grey.withValues(alpha: 0.7) : scheme.darkGrey,
    };

    return Padding(
      padding: const EdgeInsets.all(0),
      child: Material(
        color: backgroundColor,
        elevation: 2,
        shadowColor: scheme.onPrimaryContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(50),
        child: Container(
          padding: const EdgeInsets.fromLTRB(9, 12, 20, 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icono de notificación
              Container(
                alignment: Alignment.center,
                child: Icon(
                  switch (type) {
                    'access' => title.contains('aprobado')
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
                            title,
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
                          dateTimeFormatter(date),
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
                      body,
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
    );
  }
}
