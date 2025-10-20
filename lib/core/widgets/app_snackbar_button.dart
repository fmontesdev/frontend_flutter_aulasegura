import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';

enum AppSnackBarButtonVariant { primary, secondary, success, danger }
enum AppSnackBarButtonSize { sm, md, lg, xl }

class AppSnackBarButton extends StatelessWidget {
  final AppSnackBarButtonVariant variant;
  final AppSnackBarButtonSize size;
  final String? label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final String snackBarMessage;

  // Overrides opcionales por si queremos forzar colores puntuales
  final Color? backgroundColorOverride;
  final Color? foregroundColorOverride;

  const AppSnackBarButton({
    super.key,
    this.variant = AppSnackBarButtonVariant.primary,
    this.size = AppSnackBarButtonSize.md,
    this.label,
    this.icon,
    this.onPressed,
    required this.snackBarMessage,
    this.backgroundColorOverride,
    this.foregroundColorOverride,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    // Colores derivados del ColorScheme según la variante
    final (bg, fg) = switch (variant) {
      AppSnackBarButtonVariant.primary => (scheme.primary, scheme.onPrimary),
      AppSnackBarButtonVariant.secondary => (scheme.secondary, scheme.onSecondary),
      AppSnackBarButtonVariant.success => (scheme.success, scheme.onSecondary),
      AppSnackBarButtonVariant.danger => (scheme.error, scheme.onError),
    };

    // Padding y texto por tamaño
    final (padding, textStyle, iconSize) = switch (size) {
      AppSnackBarButtonSize.sm => (
          const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          theme.textTheme.labelLarge?.copyWith(fontSize: 12, fontWeight: FontWeight.w600),
          20.0,
        ),
      AppSnackBarButtonSize.md => (
          const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          theme.textTheme.labelLarge?.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
          24.0,
        ),
      AppSnackBarButtonSize.lg => (
          const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          theme.textTheme.labelLarge?.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
          28.0,
        ),
      AppSnackBarButtonSize.xl => (
          const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          theme.textTheme.labelLarge?.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
          32.0,
        ),
    };

    final resolvedBg = backgroundColorOverride ?? bg;
    final resolvedFg = foregroundColorOverride ?? fg;

    return TextButton.icon(
      onPressed: () {
        // Ejecuta el callback si existe
        onPressed?.call();

        // Muestra el SnackBar
        final messenger = ScaffoldMessenger.of(context);
        messenger.removeCurrentSnackBar();
        messenger.showSnackBar(
          SnackBar(
            content: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              child: Text(
                snackBarMessage,
                textAlign: TextAlign.center,
              ),
            ),
            backgroundColor: scheme.primary,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            margin: const EdgeInsets.all(16),
          ),
        );
      },
      icon: icon != null ? Icon(icon, size: iconSize) : const SizedBox.shrink(),
      label: label != null ? Text(label!) : const SizedBox.shrink(),
      style: ButtonStyle(
        // Ocupa todo el ancho disponible y altura según el tamaño
        minimumSize: WidgetStateProperty.all<Size>(const Size.fromHeight(46)),
        // Color de fondo
        backgroundColor: WidgetStateProperty.all<Color>(resolvedBg.withValues(alpha: 0.8)),
        // Efectos de overlay (hover, pressed, focused)
        overlayColor: WidgetStateProperty.resolveWith((states) {
          final base = resolvedFg;
          if (states.contains(WidgetState.pressed)) return base.withValues(alpha: 0.15);
          if (states.contains(WidgetState.hovered)) return base.withValues(alpha: 0.09);
          if (states.contains(WidgetState.focused)) return base.withValues(alpha: 0.12);
          return null;
        }),
        // Color del texto e ícono
        foregroundColor: WidgetStateProperty.all<Color>(resolvedFg),
        // Forma redondeada
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        // Padding
        padding: WidgetStateProperty.all<EdgeInsets>(padding),
        // Estilo del texto
        textStyle: WidgetStateProperty.all<TextStyle?>(textStyle),
      ),
    );
  }
}
