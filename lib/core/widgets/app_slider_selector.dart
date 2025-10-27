import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

enum SelectionMode { single, multi, range }

class AppSliderSelector<T> extends StatefulWidget {
  final List<T> items;
  final Widget Function(BuildContext context, T item, bool isSelected, VoidCallback onTap) itemBuilder;
  final double height;
  final double spacing;
  final SelectionMode selectionMode;
  final void Function(List<int>)? onSelectionChanged;

  const AppSliderSelector({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.height,
    this.spacing = 8,
    this.selectionMode = SelectionMode.single,
    this.onSelectionChanged,
  });

  @override
  State<AppSliderSelector<T>> createState() => _AppSliderSelectorState<T>();
}

class _AppSliderSelectorState<T> extends State<AppSliderSelector<T>> {
  late Set<int> _selected; // Siempre mantenemos índices
  int? _rangeAnchor; // Para modo range
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _selected = <int>{};
    _controller = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  // Si el widget cambia (items), conservamos selección válida y descartamos índices fuera de rango
  @override
  void didUpdateWidget(covariant AppSliderSelector<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items) {
      _selected.removeWhere((i) => i < 0 || i >= widget.items.length); // NEW
      // Si preferimos reset total al cambiar items, sustituiremos por _selected.clear();
      _rangeAnchor = null;
    }
  }

  void _handleTap(int index) {
    setState(() {
      switch (widget.selectionMode) {
        // Modo de selección única
        case SelectionMode.single:
          _selected = {index};
          _rangeAnchor = null;
          break;
        // Modo de selección múltiple
        case SelectionMode.multi:
          if (_selected.contains(index)) {
            _selected.remove(index);
          } else {
            _selected.add(index);
          }
          _rangeAnchor = null;
          break;
        // Modo de selección de rango (multiselección contigua)
        case SelectionMode.range:
          if (_rangeAnchor == null) {
            // Primer toque: fijamos ancla
            _rangeAnchor = index;
            _selected = {index};
          } else {
            // Segundo toque: seleccionamos rango [min..max]
            final start = _rangeAnchor!;
            final end = index;
            _selected = _rangeSet(start, end);
            _rangeAnchor = null; // Reseteamos para iniciar un nuevo rango en el próximo toque
          }
          break;
      }
    });

    widget.onSelectionChanged?.call(_selected.toList()..sort());
  }

  // Para el modo de selección Range (multiselección contigua), devuelve el conjunto de índices entre a y b (inclusive)
  Set<int> _rangeSet(int a, int b) {
    final start = a < b ? a : b;
    final end = a < b ? b : a;
    return {for (var i = start; i <= end; i++) i};
  }

  // Mapeo de rueda del ratón al eje horizontal
  void _onPointerSignal(PointerSignalEvent event) {
    if (event is! PointerScrollEvent || !_controller.hasClients) return;
    final pos = _controller.position;
    final target = (pos.pixels + event.scrollDelta.dy)
        .clamp(pos.minScrollExtent, pos.maxScrollExtent);
    _controller.jumpTo(target);

  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Listener( // Convierte la rueda vertical del ratón en desplazamiento horizontal
        onPointerSignal: _onPointerSignal,
        child: ScrollConfiguration( // Habilita arrastre con mouse/trackpad además de touch
          behavior: const MaterialScrollBehavior().copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
              PointerDeviceKind.stylus,
              PointerDeviceKind.trackpad,
              PointerDeviceKind.unknown,
            },
          ),
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            controller: _controller,
            primary: false, // Evita competir como scroll primario
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final item = widget.items[index];
              final isSelected = _selected.contains(index);
              return Center(
                child: widget.itemBuilder(
                  context,
                  item,
                  isSelected,
                  () => _handleTap(index),
                ),
              );
            },
            separatorBuilder: (_, _) => SizedBox(width: widget.spacing),
            itemCount: widget.items.length,
          ),
        ),
      ),
    );
  }
}
