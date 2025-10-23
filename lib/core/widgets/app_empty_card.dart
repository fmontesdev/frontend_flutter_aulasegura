import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';

class AppEmptyCard extends StatelessWidget {
  final IconData icon;
  final String message;
  const AppEmptyCard({
    super.key,
    required this.icon,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final theme  = Theme.of(context);
    final scheme = theme.colorScheme;

    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: double.infinity, // Ocupa todo el ancho disponible
        child: Material(
          color: scheme.onSecondary,
          elevation: 1.5,
          shadowColor: scheme.onPrimaryContainer.withValues(alpha: 0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
            side: BorderSide(
              color: scheme.grey.withValues(alpha: 0.2),
              width: 0.6,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 35),  
            child: Column(
              mainAxisSize: MainAxisSize.min, // para que el Column ocupe solo el espacio necesario
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon, color: scheme.lightGrey, size: 40),
                const SizedBox(height: 20),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: scheme.lightGrey,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
