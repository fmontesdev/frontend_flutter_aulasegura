import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/domain/entities/room.dart';
import 'package:frontend_flutter_aulasegura/core/l10n/app_localizations.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';

class RoomSelectableTile extends StatelessWidget {
  final Room room;
  final bool selected;
  final VoidCallback onTap;

  const RoomSelectableTile({
    super.key,
    required this.room,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;
    
    return Container(
      decoration: selected
        ? BoxDecoration(color: scheme.quatertiary.withValues(alpha: 0.2))
        : null,
      child: ListTile(
        leading: Icon(Icons.meeting_room_outlined, color: scheme.success, size: 32),
        title: Text(
          '${room.name} ${room.roomCode}',
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: scheme.secondary,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Row(
            children: [
              Icon(Icons.people_outline, size: 22, color: scheme.grey),
              const SizedBox(width: 4),
              Text(
                '${room.capacity}',
                style: textTheme.bodyMedium?.copyWith(color: scheme.grey),
              ),
              const SizedBox(width: 16),
              Icon(Icons.location_on_outlined, size: 19, color: scheme.grey),
              const SizedBox(width: 4),
              Text(
                '${l10n.building} ${room.building} - ${l10n.floor} ${room.floor}',
                style: textTheme.bodyMedium?.copyWith(color: scheme.grey),
              ),
            ],
          ),
        ),
        trailing: selected
            ? Icon(Icons.check_circle, color: scheme.tertiary, size: 26)
            : const SizedBox.shrink(),
        onTap: onTap,
      ),
    );
  }
}
