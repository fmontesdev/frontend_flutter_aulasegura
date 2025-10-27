// ignore_for_file: unreachable_switch_default

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

enum AppLinkSize { sm, md, lg }
enum AppLinkAlign { start, center, end, justify }

class AppLink extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final AppLinkSize size; // Tamaño (fuente + padding)
  final AppLinkAlign align; // Alineación
  final bool enabled; // Si lo desactivas, aplica color atenuado y deshabilita el tap
  final TextStyle? styleOverride; // Si quieres forzar estilos
  final Color? color; // Color del texto cuando está habilitado (por defecto, scheme.primary)
  final Color? disabledColor; // Color del texto cuando está deshabilitado (por defecto, onSurface 38%)
  final Color? underlineColor; // Color del subrayado (por defecto, el mismo que el texto)

  // Opciones para hover
  final Color? hoverColor;
  final Color? hoverUnderlineColor;
  final double? hoverUnderlineThickness;

  const AppLink({
    super.key,
    required this.text,
    required this.onTap,
    this.size = AppLinkSize.md,
    this.align = AppLinkAlign.center,
    this.enabled = true,
    this.styleOverride,
    this.color,
    this.disabledColor,
    this.underlineColor,
    this.hoverColor,
    this.hoverUnderlineColor,
    this.hoverUnderlineThickness,
  });

  @override
  State<AppLink> createState() => _AppLinkState();
}

class _AppLinkState extends State<AppLink> {
  bool _hovered = false;

  // ------------------- Variantes por tamaño -------------------

  ({double fontSize, double underlineThickness, EdgeInsets padding})
  _tokensForSize(AppLinkSize s) {
    switch (s) {
      case AppLinkSize.sm:
        return (
          fontSize: 13,
          underlineThickness: 0,
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6)
        );
      case AppLinkSize.lg:
        return (
          fontSize: 18,
          underlineThickness: 0,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10)
        );
      case AppLinkSize.md:
      default:
        return (
          fontSize: 15.5,
          underlineThickness: 0,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8)
        );
    }
  }

  // ------------------- Variantes por alineación -------------------

  TextAlign _toTextAlign(AppLinkAlign a) {
    switch (a) {
      case AppLinkAlign.start: return TextAlign.start;
      case AppLinkAlign.end: return TextAlign.end;
      case AppLinkAlign.justify: return TextAlign.justify;
      case AppLinkAlign.center:
      default: return TextAlign.center;
    }
  }

  Alignment _toAlignment(AppLinkAlign a) {
    switch (a) {
      case AppLinkAlign.start: return Alignment.centerLeft;
      case AppLinkAlign.end: return Alignment.centerRight;
      case AppLinkAlign.justify: return Alignment.center; // visualmente se notará en el TextAlign
      case AppLinkAlign.center:
      default: return Alignment.center;
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tokens = _tokensForSize(widget.size);
    final base = Theme.of(context).textTheme.bodyMedium ?? const TextStyle(fontSize: 14);

    // Color según estado
    final Color enabledBase = widget.color ?? scheme.primary;
    final Color disabledBase = widget.disabledColor ?? scheme.onSurface.withValues(alpha: 0.38);
    final Color underlineBase = widget.underlineColor ?? enabledBase;

    // Estado: hovered/normal y enabled/disabled
    final bool canHover = widget.enabled && (kIsWeb || Theme.of(context).platform != TargetPlatform.android);
    final bool hovered = canHover ? _hovered : false;

    // Colores según estado
    final Color textColor = widget.enabled
        ? (hovered ? (widget.hoverColor ?? enabledBase) : enabledBase)
        : disabledBase;

    final Color underlineColor = widget.enabled
        ? (hovered ? (widget.hoverUnderlineColor ?? underlineBase) : underlineBase)
        : disabledBase;

    final double underlineThickness = hovered
        ? (widget.hoverUnderlineThickness ?? tokens.underlineThickness)
        : tokens.underlineThickness;

    final textStyle = (widget.styleOverride ?? base).copyWith(
      fontSize: tokens.fontSize,
      fontWeight: FontWeight.w500,
      color: textColor,
      decoration: TextDecoration.underline,
      decorationColor: underlineColor,
      decorationThickness: underlineThickness,
    );

    // Hacemos el área clicable más cómoda y con ink
    return Align(
      alignment: _toAlignment(widget.align),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: widget.enabled ? widget.onTap : null,
          onHover: (h) => setState(() => _hovered = h),
          mouseCursor: widget.enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
          overlayColor: WidgetStateProperty.resolveWith((states) { // Overlay de Material
            if (states.contains(WidgetState.pressed)) return textColor.withValues(alpha: 0.20);
            if (states.contains(WidgetState.hovered)) return textColor.withValues(alpha: 0.15);
            if (states.contains(WidgetState.focused)) return textColor.withValues(alpha: 0.15);
            return Colors.transparent;
          }),
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: tokens.padding,
            child: Text(
              widget.text,
              textAlign: _toTextAlign(widget.align),
              style: textStyle,
            ),
          ),
        ),
      ),
    );
  }
}
