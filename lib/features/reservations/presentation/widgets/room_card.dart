import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/features/reservations/domain/entities/room.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_card.dart';
import 'package:frontend_flutter_aulasegura/core/l10n/app_localizations.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';

class RoomCard extends StatelessWidget {
  final Room room;
  final VoidCallback? onTap;

  const RoomCard({
    super.key,
    required this.room,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(40),
      child: AppCard(
        backgroundColor: scheme.surface,
        borderRadius: 40,
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Icon(Icons.meeting_room_outlined, color: scheme.success, size: 32),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${room.name} ${room.roomCode}',
                      style: text.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: scheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.people_outline, size: 22, color: scheme.grey),
                        const SizedBox(width: 4),
                        Text(
                          '${room.capacity}',
                          style: text.bodyMedium?.copyWith(color: scheme.grey),
                        ),
                        const SizedBox(width: 16),
                        Icon(Icons.location_on_outlined, size: 19, color: scheme.grey),
                        const SizedBox(width: 4),
                        Text(
                          '${l10n.building} ${room.building} - ${l10n.floor} ${room.floor}',
                          style: text.bodyMedium?.copyWith(color: scheme.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (onTap != null) Icon(Icons.chevron_right, color: scheme.grey),
            ],
          ),
        ],
      ),
    );
  }
}
