import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';

class AppSectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;
  final IconData? trailingIcon;
  final Widget? trailing;

  const AppSectionTitle({
    super.key,
    required this.icon,
    required this.title,
    this.trailingIcon,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Icon(icon, color: scheme.titles),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: text.titleLarge?.copyWith(
                      color: scheme.titles,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            if (trailingIcon != null)
              Icon(trailingIcon, color: scheme.titles)
            else if (trailing != null)
              trailing!,
          ],
        ),
      ),
    );
  }
}
