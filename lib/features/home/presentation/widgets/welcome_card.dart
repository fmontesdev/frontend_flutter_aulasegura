import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';
import 'package:frontend_flutter_aulasegura/core/l10n/app_localizations.dart';

class WelcomeCard extends StatelessWidget {
  final String date;
  final String name;
  final String role;
  final String avatarUrl;

  const WelcomeCard({
    super.key,
    required this.date,
    required this.name,
    required this.role,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    final theme  = Theme.of(context);
    final scheme = theme.colorScheme;
    final l10n   = AppLocalizations.of(context)!;

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
          /// Avatar circular
          CircleAvatar(
            radius: 50, // radio del avatar
            backgroundImage: CachedNetworkImageProvider(avatarUrl), // Carga imagen desde URL con caché
          ),
          const SizedBox(width: 16),

          // Texto (fecha, nombre, rol)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Fecha
                Text(
                  date,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: scheme.grey,
                  ),
                ),
                const SizedBox(height: 1),
                /// Hola Nombre!
                Text(
                  l10n.salute(name), //? Nombre del usuario autenticado con internacionalización
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.headlineLarge?.copyWith(
                    color: scheme.secondary,
                  ),
                ),
                const SizedBox(height: 1),
                /// Rol
                Text(
                  l10n.role(role), //? Rol del usuario autenticado con internacionalización
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