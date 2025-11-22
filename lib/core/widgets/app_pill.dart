import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';

enum AppPillVariant { primary, secondary, tertiary, quatertiary, success, error }
enum AppPillSize { sm, md, lg, xl }

class AppPill extends StatelessWidget {
  final AppPillVariant variant;
  final AppPillSize size;
  final IconData? icon;
  final String label;

  const AppPill({
    super.key,
    this.variant = AppPillVariant.primary,
    this.size = AppPillSize.md,
    this.icon,
    required this.label
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final text   = theme.textTheme;

    // Colores por variante
    final (background, foreground) = switch (variant) {
      AppPillVariant.primary => (scheme.primary, scheme.onPrimary),
      AppPillVariant.secondary => (scheme.secondary, scheme.onSecondary),
      AppPillVariant.tertiary => (scheme.tertiary, scheme.onTertiary),
      AppPillVariant.quatertiary => (scheme.quatertiary.withValues(alpha: 0.4), scheme.secondary),
      AppPillVariant.success => (scheme.success.withValues(alpha: 0.14), scheme.success),
      AppPillVariant.error => (scheme.lightRed, scheme.error),
    };

    // Padding, tipo de texto y icono por tamaño
    final (padding, textStyle, iconSize) = switch (size) {
      AppPillSize.sm => (
        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        text.labelLarge?.copyWith(color: foreground),
        18.0,
      ),
      AppPillSize.md => (
        const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        text.labelLarge?.copyWith(fontSize: 15, color: foreground),
        20.0,
      ),
      AppPillSize.lg => (
        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        text.labelLarge?.copyWith(fontSize: 16, color: foreground),
        22.0,
      ),
      AppPillSize.xl => (
        const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        text.labelLarge?.copyWith(fontSize: 18, color: foreground, fontWeight: FontWeight.w600),
        26.0,
      ),
    };

    return Container(
      padding: padding,
      decoration: ShapeDecoration(
        color: background,
        shape: const StadiumBorder(),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Icono
          if (icon != null) ...[
            Icon(icon!, color: foreground, size: iconSize),
            const SizedBox(width: 6),
          ],
          /// Info
          Text(label, style: textStyle),
        ],
      ),
    );
  }
}