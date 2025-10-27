import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';

class AppScheduleCard extends StatefulWidget {
  final String classroom;
  final String group;
  final String timeRange;
  final String subject;

  const AppScheduleCard({
    super.key,
    required this.classroom,
    required this.group,
    required this.timeRange,
    required this.subject,
  });

  @override
  State<AppScheduleCard> createState() => _AppScheduleCardState();
}

class _AppScheduleCardState extends State<AppScheduleCard> {
  bool _isHover = false; // Estado de hover para cambiar el borde

  @override
  Widget build(BuildContext context) {
    final theme  = Theme.of(context);
    final scheme = theme.colorScheme;

    // Altura y Colores de sombreado (tenue / hover)
    final Color baseShadow = scheme.onPrimaryContainer.withValues(alpha: 0.4);
    final Color hoverShadow = scheme.onPrimaryContainer.withValues(alpha: 0.6);
    final shadowColor = _isHover ? hoverShadow : baseShadow;

    final double baseElevation = 1.5;
    final double hoverElevation = 3.5;
    final elevation = _isHover ? hoverElevation : baseElevation;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHover = true),
      onExit:  (_) => setState(() => _isHover = false),
      // cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150), // Para animar suavemente el cambio del sombreado
        curve: Curves.easeInOut,
        child: Material(
          color: scheme.onSecondary,
          elevation: elevation,
          shadowColor: shadowColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
            side: BorderSide(
              color: scheme.grey.withValues(alpha: 0.2),
              width: 0.6,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 12, 22, 12),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Aula
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined, color: scheme.secondary, size: 19),
                          const SizedBox(width: 3),
                          Text(
                            widget.classroom,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: scheme.secondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),

                      // Grupo
                      Row(
                        children: [
                          Icon(Icons.school_outlined, color: scheme.grey, size: 19),
                          const SizedBox(width: 6),
                          Text(
                            widget.group,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontSize: 15.5,
                              color: scheme.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Horario
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.access_time, color: scheme.secondary, size: 19),
                          const SizedBox(width: 6),
                          Text(
                            widget.timeRange,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: scheme.secondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),

                      // Materia
                      Text(
                        widget.subject,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 15.5,
                          color: scheme.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
