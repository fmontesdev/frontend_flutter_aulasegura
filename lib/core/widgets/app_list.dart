import 'package:flutter/material.dart';

class AppList<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(T item) itemBuilder;

  const AppList({
    super.key,
    required this.items,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(child: Text('No hay datos para mostrar'));
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final isLast = index == items.length - 1;

        return Padding(
          padding: EdgeInsets.only(bottom: isLast ? 0 : 13),
          child: itemBuilder(item),
        );
      },
    );
  }
}
