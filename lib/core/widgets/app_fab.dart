import 'package:flutter/material.dart';

enum AppFabVariant { primary, secondary, danger }
enum AppFabSize { sm, md, lg }

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
    final text = theme.textTheme;

    // Colores derivados del ColorScheme
    final (bg, fg) = switch (variant) {
      AppFabVariant.primary => (scheme.primary, scheme.onPrimary),
      AppFabVariant.secondary => (scheme.tertiary, scheme.onTertiary),
      AppFabVariant.danger => (scheme.error, scheme.onError),
    };

    final resolvedBg = backgroundColorOverride ?? bg;
    final resolvedFg = foregroundColorOverride ?? fg;

    // Icono, Texto y Padding según tamaño
    final (iconSize, textStyle, horizontalPadding) = switch (size) {
      AppFabSize.sm => (
        24.0,
        text.titleSmall?.copyWith(
          color: resolvedFg,
        ),
        const EdgeInsets.only(left: 11, right: 20), // El padding vertical viene fijo en FloatingActionButton
      ),
      AppFabSize.md => (
        32.0,
        text.titleMedium?.copyWith(
          color: resolvedFg,
        ),
        const EdgeInsets.only(left: 15, right: 24), // El padding vertical viene fijo en FloatingActionButton
      ),
      AppFabSize.lg => (
        40.0,
        text.titleLarge?.copyWith(
          color: resolvedFg,
        ),
        const EdgeInsets.only(left: 19, right: 28), // El padding vertical viene fijo en FloatingActionButton
      ),
    };

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
        shape: const CircleBorder(),
        onPressed: onPressed,
        child: Icon(icon, size: iconSize),
      );
    }

    return Padding(
      padding: EdgeInsets.zero,
      child: FloatingActionButton.extended(
        heroTag: heroTag,
        tooltip: tooltip,
        elevation: 2,
        hoverElevation: 3,
        backgroundColor: resolvedBg,
        foregroundColor: resolvedFg,
        shape: const StadiumBorder(),
        icon: Icon(icon, size: iconSize),
        label: Text(label!, style: textStyle),
        extendedPadding: horizontalPadding,
        onPressed: onPressed,
      ),
    );
  }
}