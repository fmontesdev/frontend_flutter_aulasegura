import 'package:flutter/material.dart';

enum AppButtonVariant { primary, secondary, danger }
enum AppButtonSize { sm, md, lg }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;

  /// Overrides opcionales por si queremos forzar colores puntuales
  final Color? backgroundColorOverride;
  final Color? foregroundColorOverride;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.md,
    this.backgroundColorOverride,
    this.foregroundColorOverride,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    // Colores derivados del ColorScheme
    final (bg, fg) = switch (variant) {
      AppButtonVariant.primary => (scheme.primary, scheme.onPrimary),
      AppButtonVariant.secondary => (scheme.secondary, scheme.onSecondary),
      AppButtonVariant.danger => (scheme.error, scheme.onError),
    };

    // Padding y texto por tamaño
    final (padding, textStyle) = switch (size) {
      AppButtonSize.sm => (
          const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          (theme.textTheme.labelLarge ?? const TextStyle(fontSize: 14))
              .copyWith(fontSize: 13)
        ),
      AppButtonSize.md => (
          const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          theme.textTheme.labelLarge ?? const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)
        ),
      AppButtonSize.lg => (
          const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          (theme.textTheme.labelLarge ?? const TextStyle(fontSize: 14))
              .copyWith(fontSize: 16, fontWeight: FontWeight.w600)
        ),
    };

    final resolvedBg = backgroundColorOverride ?? bg;
    final resolvedFg = foregroundColorOverride ?? fg;

    return ElevatedButton(
      style: theme.elevatedButtonTheme.style?.copyWith(
        backgroundColor: WidgetStatePropertyAll(resolvedBg),
        foregroundColor: WidgetStatePropertyAll(resolvedFg),
        padding: WidgetStatePropertyAll(padding),
        textStyle: WidgetStatePropertyAll(textStyle),
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
