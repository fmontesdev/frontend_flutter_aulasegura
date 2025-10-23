import 'package:flutter/material.dart';

enum AppFabVariant { primary, secondary, danger }
enum AppFabSize { sm, md, lg, xl }

class AppFab extends StatelessWidget {
  final AppFabVariant variant;
  final AppFabSize size;
  final String? label;
  final IconData? icon;
  final Object? heroTag;
  final String? tooltip;
  final VoidCallback onPressed;

  // Overrides opcionales por si queremos forzar colores puntuales
  final Color? backgroundColorOverride;
  final Color? foregroundColorOverride;

  const AppFab({
    super.key,
    this.variant = AppFabVariant.primary,
    this.size = AppFabSize.md,
    this.label,
    this.icon,
    this.heroTag,
    this.tooltip,
    required this.onPressed,
    this.backgroundColorOverride,
    this.foregroundColorOverride,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    // Colores derivados del ColorScheme
    final (bg, fg) = switch (variant) {
      AppFabVariant.primary => (scheme.primary, scheme.onPrimary),
      AppFabVariant.secondary => (scheme.secondary, scheme.onPrimary),
      AppFabVariant.danger => (scheme.error, scheme.onError),
    };

    // Padding y texto por tamaño
    final (iconSize, internalPadding) = switch (size) {
      AppFabSize.sm => (
        24.0,
        const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
      AppFabSize.md => (
        28.0,
        const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      AppFabSize.lg => (
        32.0,
        const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      ),
      AppFabSize.xl => (
        36.0,
        const EdgeInsets.symmetric(horizontal: 26, vertical: 31),
      ),
    };

    final resolvedBg = backgroundColorOverride ?? bg;
    final resolvedFg = foregroundColorOverride ?? fg;

    final bool isExtended = label != null && label!.isNotEmpty;

    // FAB circular
    if (!isExtended) {
      return FloatingActionButton(
        heroTag: heroTag,
        tooltip: tooltip,
        elevation: 2,
        hoverElevation: 3,
        backgroundColor: resolvedBg,
        foregroundColor: resolvedFg,
        onPressed: onPressed,
        shape: const CircleBorder(),
        child: Icon(icon, size: iconSize),
      );
    }

    // FAB extendido (pill)
    final textStyle = theme.textTheme.labelLarge?.copyWith(
      fontWeight: FontWeight.w600,
    );

    return Padding(
      padding: EdgeInsets.zero,
      child: FloatingActionButton.extended(
        heroTag: heroTag,
        tooltip: tooltip,
        elevation: 2,
        hoverElevation: 3,
        backgroundColor: resolvedBg,
        foregroundColor: resolvedFg,
        label: Padding(
          padding: internalPadding,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: iconSize),
              const SizedBox(width: 10),
              Text(label!, style: textStyle),
            ],
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
