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

    return Padding(
      padding: const EdgeInsets.all(0),
      child: Material(
        color: scheme.surface,
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(50),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            children: [
              // Avatar circular
              ClipOval(
                child: Image.asset(
                  avatar,
                  width: 90,
                  height: 90,
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: scheme.grey,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 2),
                    // Hola, Nombre
                    Text(
                      'Hola, $name!',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.headlineLarge?.copyWith(
                        color: scheme.secondary,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 2),
                    // Rol
                    Text(
                      role,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
    );
  }
}

