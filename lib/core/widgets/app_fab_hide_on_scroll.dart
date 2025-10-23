import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Envuelve el FAB y lo oculta al hacer scroll hacia abajo, lo muestra al subir.
class AppFabHideOnScroll extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;

  const AppFabHideOnScroll({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 180),
    this.curve = Curves.easeOut,
  });

  @override
  State<AppFabHideOnScroll> createState() => _AppFabHideOnScrollState();
}

class _AppFabHideOnScrollState extends State<AppFabHideOnScroll> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<UserScrollNotification>(
      onNotification: (notif) {
        final direction = notif.direction;
        final shouldShow = direction == ScrollDirection.forward || direction == ScrollDirection.idle;
        if (shouldShow != _visible) {
          setState(() => _visible = shouldShow);
        }
        return false;
      },
      child: AnimatedSlide(
        duration: widget.duration,
        curve: widget.curve,
        offset: _visible ? Offset.zero : const Offset(0, 1.2),
        child: AnimatedOpacity(
          duration: widget.duration,
          curve: widget.curve,
          opacity: _visible ? 1 : 0,
          child: widget.child,
        ),
      ),
    );
  }
}
