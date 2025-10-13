import 'package:flutter/material.dart';

enum AppLinkSize { sm, md, lg }
enum AppLinkAlign { start, center, end, justify }

class AppLink extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final AppLinkSize size; // Tamaño (fuente + padding)
  final AppLinkAlign align; // Alineación
  final bool enabled; // Si lo desactivas, aplica color atenuado y deshabilita el tap
  final TextStyle? styleOverride; // Si quieres forzar estilos
  final Color? color; // Color del texto cuando está habilitado (por defecto, scheme.primary)
  final Color? disabledColor; // Color del texto cuando está deshabilitado (por defecto, onSurface 38%)
  final Color? underlineColor; // Color del subrayado (por defecto, el mismo que el texto)

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
  });

  // ------------------- Variantes por tamaño -------------------

  ({double fontSize, double underlineThickness, EdgeInsets padding})
  _tokensForSize(AppLinkSize s) {
    switch (s) {
      case AppLinkSize.sm:
        return (fontSize: 13, underlineThickness: 1.2, padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6));
      case AppLinkSize.lg:
        return (fontSize: 16, underlineThickness: 1.7, padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10));
      case AppLinkSize.md:
      default:
        return (fontSize: 14, underlineThickness: 1.4, padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8));
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
    final tokens = _tokensForSize(size);
    final base = Theme.of(context).textTheme.bodyMedium ?? const TextStyle(fontSize: 14);

    // Color según estado
    final Color enabledBase = color ?? scheme.primary;
    final Color disabledBase = disabledColor ?? scheme.onSurface.withValues(alpha: 0.38);
    final Color linkColor = enabled ? enabledBase : disabledBase;

    final textStyle = (styleOverride ?? base).copyWith(
      fontSize: tokens.fontSize,
      fontWeight: FontWeight.w600,
      color: linkColor,
      decoration: TextDecoration.underline,
      decorationColor: linkColor,
      decorationThickness: tokens.underlineThickness,
    );

    // Hacemos el área clicable más cómoda y con ink
    return Align(
      alignment: _toAlignment(align),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: enabled ? onTap : null,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: tokens.padding,
            child: Text(
              text,
              textAlign: _toTextAlign(align),
              style: textStyle,
            ),
          ),
        ),
      ),
    );
  }
}
