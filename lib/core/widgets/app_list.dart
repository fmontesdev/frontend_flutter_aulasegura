import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_empty_card.dart';

class AppList<T> extends StatelessWidget {
  final String type;
  final List<T> items;
  final Widget Function(T item) itemBuilder;

  const AppList({
    super.key,
    required this.type,
    required this.items,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final IconData icon;
    final String message;

    switch (type) {
      case 'schedules':
        icon = Icons.access_time;
        message = 'No hay horarios disponibles';
        break;
      case 'reservations':
        icon = Icons.event_busy_outlined;
        message = 'No hay reservas disponibles';
        break;
      case 'notifications':
        icon = Icons.notifications_off_outlined;
        message = 'No hay notificaciones disponibles';
        break;
      default:
        icon = Icons.data_object;
        message = 'No hay datos para mostrar';
    }

    if (items.isEmpty) {
      return AppEmptyCard(
        icon: icon,
        message: message,
      );
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 13),
          child: itemBuilder(item),
        );
      },
    );
  }
}
