import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';

enum AppButtonVariant { primary, secondary, danger, lightRed }
enum AppButtonSize { sm, md, lg, xl }

class AppButton extends StatelessWidget {
  final AppButtonVariant variant;
  final AppButtonSize size;
  final String? label;
  final IconData? icon;
  final VoidCallback onPressed;
  final bool isCircular;
  final bool border;
  final bool overlayColor;

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
    this.border = false,
    this.overlayColor = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    /// Colores derivados del ColorScheme
    final (bg, fg) = switch (variant) {
      AppButtonVariant.primary => (scheme.primary, scheme.onPrimary),
      AppButtonVariant.secondary => (scheme.tertiary, scheme.onTertiary),
      AppButtonVariant.danger => (scheme.error, scheme.onError),
      AppButtonVariant.lightRed => (scheme.lightRed, scheme.error.withValues(alpha: 0.6)),
    };

    /// Padding y texto por tamaño
    final (padding, textStyle) = switch (size) {
      AppButtonSize.sm => (
        const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        theme.textTheme.titleSmall,
      ),
      AppButtonSize.md => (
        const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
        theme.textTheme.titleMedium,
      ),
      AppButtonSize.lg => (
        const EdgeInsets.symmetric(horizontal: 18, vertical: 17),
        theme.textTheme.titleLarge,
      ),
      AppButtonSize.xl => (
        const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
        theme.textTheme.titleLarge?.copyWith(fontSize: 22)
      ),
    };

    final resolvedBg = backgroundColorOverride ?? bg;
    final resolvedFg = foregroundColorOverride ?? fg;

    /// Define la forma del botón y el borde si existe
    final shape = isCircular
        ? CircleBorder(
            side: border
              ? BorderSide(
                  color: resolvedFg,
                  width: 1.5,
                )
              : BorderSide.none,
          )

        : StadiumBorder(
            side: border
              ? BorderSide(
                  color: resolvedFg,
                  width: 1.5,
                )
              : BorderSide.none,
        );

    /// Define el overlayColor si existe
    final overlay = WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) return resolvedFg.withValues(alpha: 0.10);
      if (states.contains(WidgetState.hovered)) return resolvedFg.withValues(alpha: 0.09);
      if (states.contains(WidgetState.focused))  return resolvedFg.withValues(alpha: 0.09);
      return null;
    });

    return ElevatedButton(
      style: theme.elevatedButtonTheme.style?.copyWith(
        backgroundColor: WidgetStatePropertyAll(resolvedBg),
        foregroundColor: WidgetStatePropertyAll(resolvedFg),
        padding: WidgetStatePropertyAll(padding),
        textStyle: WidgetStatePropertyAll(textStyle),
        shape: WidgetStatePropertyAll(shape),
        overlayColor: overlayColor ? overlay : null,
      ),
      onPressed: onPressed,
      child: label != null && icon == null
          ? Text(label!)

        : label != null && icon != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 20),
                  const SizedBox(width: 6),
                  Text(label!),
                ],
              )

        : Icon(icon, size: 82.5)
    );
  }
}