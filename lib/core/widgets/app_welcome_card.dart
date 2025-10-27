import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';

class AppWelcomeCard extends StatelessWidget {
  final String date;
  final String name;
  final String role;
  final String avatar;

  const AppWelcomeCard({
    super.key,
    required this.date,
    required this.name,
    required this.role,
    required this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    final theme  = Theme.of(context);
    final scheme = theme.colorScheme;

    return Material(
      color: scheme.onSecondary,
      elevation: 1.5,
      shadowColor: scheme.onPrimaryContainer.withValues(alpha: 0.4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        side: BorderSide(
          color: scheme.grey.withValues(alpha: 0.2),
          width: 0.6,
        ),
      ),
      child: Row(
        children: [
          // Avatar circular
          ClipOval(
            child: Image.asset(
              avatar,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              semanticLabel: 'Avatar Clara',
            ),
          ),
          const SizedBox(width: 16),

          // Texto (fecha, nombre, rol)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Fecha
                Text(
                  date,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: scheme.grey,
                  ),
                ),
                const SizedBox(height: 1),
                // Hola Nombre!
                Text(
                  'Hola $name!',
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.headlineLarge?.copyWith(
                    color: scheme.secondary,
                  ),
                ),
                const SizedBox(height: 1),
                // Rol
                Text(
                  role,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: scheme.darkGrey,
                    // fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
