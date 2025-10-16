import 'package:flutter/material.dart';

enum AppButtonVariant { primary, secondary, danger }
enum AppButtonSize { sm, md, lg, xl }

class AppButton extends StatelessWidget {
  final AppButtonVariant variant;
  final AppButtonSize size;
  final String? label;
  final IconData? icon;
  final VoidCallback onPressed;
  final bool isCircular;

  // Overrides opcionales por si queremos forzar colores puntuales
  final Color? backgroundColorOverride;
  final Color? foregroundColorOverride;

  const AppButton({
    super.key,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.md,
    this.label,
    this.icon,
    required this.onPressed,
    this.backgroundColorOverride,
    this.foregroundColorOverride,
    this.isCircular = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    // Colores derivados del ColorScheme
    final (bg, fg) = switch (variant) {
      AppButtonVariant.primary => (scheme.primary, scheme.onPrimary),
      AppButtonVariant.secondary => (scheme.secondary, scheme.onPrimary),
      AppButtonVariant.danger => (scheme.error, scheme.onError),
    };

    // Padding y texto por tamaño
    final (padding, textStyle) = switch (size) {
      AppButtonSize.sm => (
          const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          theme.textTheme.labelLarge?.copyWith(fontSize: 12, fontWeight: FontWeight.w600)
        ),
      AppButtonSize.md => (
          const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          theme.textTheme.labelLarge?.copyWith(fontSize: 14, fontWeight: FontWeight.w600)
        ),
        AppButtonSize.lg => (
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            theme.textTheme.labelLarge?.copyWith(fontSize: 18, fontWeight: FontWeight.w600)
          ),
      AppButtonSize.xl => (
          const EdgeInsets.symmetric(horizontal: 26, vertical: 31),
          theme.textTheme.labelLarge?.copyWith(fontSize: 22, fontWeight: FontWeight.w600)
        ),
    };

    final resolvedBg = backgroundColorOverride ?? bg;
    final resolvedFg = foregroundColorOverride ?? fg;

    // Define el botón redondo
    final shape = isCircular
        ? const CircleBorder()
        : const StadiumBorder();

    return ElevatedButton(
      style: theme.elevatedButtonTheme.style?.copyWith(
        backgroundColor: WidgetStatePropertyAll(resolvedBg),
        foregroundColor: WidgetStatePropertyAll(resolvedFg),
        padding: WidgetStatePropertyAll(padding),
        textStyle: WidgetStatePropertyAll(textStyle),
        shape: WidgetStatePropertyAll(shape),
      ),
      onPressed: onPressed,
      child: label != null && icon == null
          ? Text(label!)
          : Icon(icon, size: 105)
    );
  }
}
