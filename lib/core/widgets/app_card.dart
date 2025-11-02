import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';

class AppCard extends StatelessWidget {
  final Color? backgroundColor;
  final Color? borderColor;
  final double? elevation;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final CrossAxisAlignment? alignment;
  final String? title;
  final List<Widget> children; // contenido de la card

  const AppCard({
    super.key,
    this.backgroundColor,
    this.borderColor,
    this.elevation,
    this.borderRadius,
    this.padding,
    this.alignment,
    this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final text = theme.textTheme;

    return Material(
      color: backgroundColor ?? scheme.onSecondary,
      elevation: elevation ?? 1.5,
      shadowColor: scheme.onPrimaryContainer.withValues(alpha: 0.4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 40),
        side: BorderSide(
          color: (borderColor ?? scheme.grey).withValues(alpha: 0.2),
          width: 0.6,
        ),
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: alignment ?? CrossAxisAlignment.start,
          children: [
            if (title != null) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(title!, style: text.titleMedium?.copyWith(
                    color: scheme.secondary,
                  )),
                ),
              ),
              const SizedBox(height: 6),
            ],
            ...children,
          ],
        ),
      ),
    );
  }
}