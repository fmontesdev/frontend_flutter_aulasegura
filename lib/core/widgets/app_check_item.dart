import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';

//* Widget reutilizable para mostrar un elemento con estado de verificación
class AppCheckItem extends StatelessWidget {
  final String text; // Texto que se muestra junto al icono
  final bool isChecked; // Si el elemento está verificado o no
  final Color? checkedColor; // Color personalizado cuando está verificado (opcional)
  final Color? uncheckedColor; // Color personalizado cuando no está verificado (opcional)
  final IconData? checkedIcon; // Icono personalizado cuando está verificado (opcional)
  final IconData? uncheckedIcon; // Icono personalizado cuando no está verificado (opcional)
  final double? iconSize; // Tamaño del icono (opcional)
  final EdgeInsetsGeometry? padding; // Padding personalizado (opcional)

  const AppCheckItem({
    super.key,
    required this.text,
    required this.isChecked,
    this.checkedColor,
    this.uncheckedColor,
    this.checkedIcon,
    this.uncheckedIcon,
    this.iconSize,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final effectiveCheckedColor = checkedColor ?? scheme.success;
    final effectiveUncheckedColor = uncheckedColor ?? scheme.secondary.withValues(alpha: 0.5);

    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          Icon(
            isChecked 
              ? (checkedIcon ?? Icons.check_circle) 
              : (uncheckedIcon ?? Icons.radio_button_unchecked),
            size: iconSize ?? 18,
            color: isChecked ? effectiveCheckedColor : effectiveUncheckedColor,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: textTheme.bodyMedium?.copyWith(
                color: isChecked 
                  ? effectiveCheckedColor 
                  : scheme.secondary.withValues(alpha: 0.7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
