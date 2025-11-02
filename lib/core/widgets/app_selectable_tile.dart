import 'package:flutter/material.dart';

class SelectableTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const SelectableTile({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    
    return ListTile(
      leading: Icon(icon, color: scheme.secondary),
      title: Text(label),
      trailing: selected
          ? Icon(Icons.check_circle, color: scheme.tertiary)
          : const SizedBox.shrink(),
      onTap: onTap,
    );
  }
}