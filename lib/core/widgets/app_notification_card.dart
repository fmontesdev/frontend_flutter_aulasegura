import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';

class AppNotificationCard extends StatelessWidget {
  final String? type;
  final IconData icon;
  final String title;
  final String date;
  final String body;

  const AppNotificationCard({
    super.key,
    this.type,
    required this.icon,
    required this.title,
    required this.date,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final theme  = Theme.of(context);
    final scheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.all(0),
      child: Material(
        color: scheme.onSecondary,
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
                child: Icon(icon, color: scheme.darkGrey, size: 30),
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
                              color: scheme.secondary,
                              fontSize: 17,
                              height: 1.2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        // Fecha
                        Text(
                          date,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: scheme.grey,
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
                        // color: scheme.darkGrey,
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

