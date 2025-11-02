import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';

class IconOptionTile extends StatelessWidget {
  final IconData icon;
  final Color? iconBg;
  final Color? iconColor;
  final String title;
  final String subtitle;
  final Widget trailing;
  final VoidCallback? onTap;

  const IconOptionTile({
    super.key,
    required this.icon,
    this.iconBg,
    this.iconColor,
    required this.title,
    required this.subtitle,
    required this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final text   = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),

      /// Icono circular
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: iconBg ?? scheme.primaryContainer,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Icon(icon, color: iconColor ?? scheme.secondary, size: 28),
      ),

      /// Título y subtítulo
      title: Text(
        title,
        style: text.titleMedium?.copyWith(
          color: scheme.onSurface,
          fontWeight: FontWeight.w500,
          fontSize: 17,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: text.bodyMedium?.copyWith(
          color: scheme.grey,
          fontSize: 14,
        ),
      ),

      /// Trailing
      trailing: trailing,

      /// Ripple y acción
      onTap: onTap,
      shape: RoundedRectangleBorder( // Para ripple circular
        borderRadius: BorderRadius.circular(40),
      ),
    );
  }
}