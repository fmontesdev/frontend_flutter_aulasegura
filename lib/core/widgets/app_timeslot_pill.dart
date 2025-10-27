import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/domain/entities/time_slot.dart';
import 'package:frontend_flutter_aulasegura/core/utils/date_formatter.dart';

enum AppTSPillVariant { primary, secondary, tertiary }
enum AppTSPillSize { sm, md, lg }

class AppTimeSlotPill extends StatelessWidget {
  final AppTSPillVariant variant;
  final AppTSPillSize size;
  final TimeSlot timeSlot;
  final void Function()? onTap;
  final bool isSelected;
  final bool isCircular; // útil para píldoras sólo con icono
  final bool enabled;

  const AppTimeSlotPill({
    super.key,
    this.variant = AppTSPillVariant.primary,
    this.size = AppTSPillSize.md,
    required this.timeSlot,
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
      AppTSPillVariant.primary => (scheme.primary, scheme.onPrimary),
      AppTSPillVariant.secondary => (scheme.secondary, scheme.onSecondary),
      AppTSPillVariant.tertiary => (scheme.tertiary, scheme.onTertiary),
    };

    // Estado base de la pill: blanco con sombra, estado seleccionado = variante
    final Color background = isSelected ? selBg : scheme.card;
    final Color foreground1 = isSelected ? selFg : scheme.onSurface;
    final Color foreground2 = isSelected ? selFg : scheme.darkGrey.withValues(alpha: 0.7);
    // Grosor de la fuente según estado seleccionado
    final FontWeight fontWeight = isSelected ? FontWeight.w600 : FontWeight.w400;

    // Padding, tipo de texto y icono por tamaño
    final (padding, textStyleStart, textStyleEnd) = switch (size) {
      AppTSPillSize.sm => (
        const EdgeInsets.symmetric(horizontal: 11, vertical: 9),
        theme.textTheme.labelMedium?.copyWith(fontWeight: fontWeight, color: foreground1),
        theme.textTheme.labelSmall?.copyWith(fontWeight: fontWeight, color: foreground2),
      ),
      AppTSPillSize.md => (
        const EdgeInsets.symmetric(horizontal: 13.7, vertical: 11.7),
        theme.textTheme.labelLarge?.copyWith(fontSize: 16, fontWeight: fontWeight, color: foreground1),
        theme.textTheme.labelMedium?.copyWith(fontSize: 13, fontWeight: FontWeight.w500, color: foreground2),
      ),
      AppTSPillSize.lg => (
        const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        theme.textTheme.bodyLarge?.copyWith(fontSize: 18, fontWeight: fontWeight, color: foreground1),
        theme.textTheme.bodyMedium?.copyWith(fontSize: 15, fontWeight: fontWeight, color: foreground2),
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
            child: Column(
              mainAxisSize: MainAxisSize.min, // Utiliza el mínimo espacio vertical necesario
              children: [
                Text(
                  timeFormatter(DateTime.parse('1970-01-01T${timeSlot.startTime}')),
                  style: textStyleStart
                ),
                const SizedBox(height: 3),
                Text(
                  timeFormatter(DateTime.parse('1970-01-01T${timeSlot.endTime}')),
                  style: textStyleEnd
                ),
              ],  
            ),
          ),
        ),
      ),
    );
  }
}