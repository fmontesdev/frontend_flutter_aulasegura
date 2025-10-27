import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';

enum AppPillVariant { primary, secondary, tertiary }
enum AppPillSize { sm, md, lg }

class AppPill extends StatelessWidget {
  final AppPillVariant variant;
  final AppPillSize size;
  final String? label;
  final IconData? icon;
  final void Function()? onTap;
  final bool isSelected;
  final bool isCircular; // útil para píldoras sólo con icono
  final bool enabled;

  const AppPill({
    super.key,
    this.variant = AppPillVariant.primary,
    this.size = AppPillSize.md,
    this.label,
    this.icon,
    this.onTap,
    this.isSelected = false,
    this.isCircular = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    // Colores por variante para el estado seleccionado
    final (selBg, selFg) = switch (variant) {
      AppPillVariant.primary => (scheme.primary, scheme.onPrimary),
      AppPillVariant.secondary => (scheme.secondary, scheme.onSecondary),
      AppPillVariant.tertiary => (scheme.tertiary, scheme.onTertiary),
    };

    // Estado base de la pill: blanco con sombra, estado seleccionado = variante
    final Color background = isSelected ? selBg : scheme.card;
    final Color foreground = isSelected ? selFg : scheme.onSurface;
    // Grosor de la fuente según estado seleccionado
    final FontWeight fontWeight = isSelected ? FontWeight.w600 : FontWeight.w500;

    // Padding, tipo de texto y icono por tamaño
    final (padding, textStyle, iconSize) = switch (size) {
      AppPillSize.sm => (
        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        theme.textTheme.labelSmall?.copyWith(fontWeight: fontWeight, color: foreground),
        14.0,
      ),
      AppPillSize.md => (
        const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
        theme.textTheme.labelMedium?.copyWith(fontWeight: fontWeight, color: foreground),
        16.0,
      ),
      AppPillSize.lg => (
        const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        theme.textTheme.labelLarge?.copyWith(fontWeight: fontWeight, color: foreground),
        18.0,
      ),
    };

    final shape = isCircular ? const CircleBorder() : const StadiumBorder();

    return Opacity(
      opacity: enabled ? 1.0 : 0.5,
      child: Material(
        color: background,
        shape: shape,
        elevation: 2,
        shadowColor: scheme.onPrimaryContainer.withValues(alpha: 0.4),
        surfaceTintColor: isSelected ? null : Colors.transparent, // Evita tinte M3 sobre blanco
        child: InkWell(
          customBorder: shape,
          onTap: enabled ? onTap : null,
          child: Padding(
            padding: padding,
            child: () {
              final hasText = (label != null && label!.trim().isNotEmpty);
              final hasIcon = icon != null;

              // Sólo texto
              if (hasText && !hasIcon) {
                return Text(label!, style: textStyle);
              }
              // Sólo icono
              if (!hasText && hasIcon) {
                return Icon(icon, size: iconSize, color: foreground);
              }
              // Icono + texto
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: iconSize, color: foreground),
                  const SizedBox(width: 8),
                  Text(label ?? '', style: textStyle),
                ],
              );
            }(),
          ),
        ),
      ),
    );
  }
}