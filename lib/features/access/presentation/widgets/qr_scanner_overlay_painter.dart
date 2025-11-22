import 'package:flutter/material.dart';

/// Painter para crear el overlay con el recuadro de escaneo
class QrScannerOverlayPainter extends CustomPainter {
  final Color borderColor;
  final double borderWidth;
  final double borderLength;
  final double borderRadius;
  final double cutOutSize;

  QrScannerOverlayPainter({
    required this.borderColor,
    required this.borderWidth,
    required this.borderLength,
    required this.borderRadius,
    required this.cutOutSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final cutOutLeft = (width - cutOutSize) / 2;
    final cutOutTop = (height - cutOutSize) / 2;

    // Fondo semitransparente
    final backgroundPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, width, height));

    final cutOutPath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(cutOutLeft, cutOutTop, cutOutSize, cutOutSize),
          Radius.circular(borderRadius),
        ),
      );

    final overlayPath = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cutOutPath,
    );

    canvas.drawPath(
      overlayPath,
      Paint()..color = Colors.black.withValues(alpha: 0.5),
    );

    // Esquinas del recuadro
    final borderPaint = Paint()
      ..color = borderColor
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke;

    // Esquina superior izquierda
    canvas.drawPath(
      Path()
        ..moveTo(cutOutLeft + borderRadius, cutOutTop)
        ..lineTo(cutOutLeft + borderLength, cutOutTop)
        ..moveTo(cutOutLeft, cutOutTop + borderRadius)
        ..lineTo(cutOutLeft, cutOutTop + borderLength),
      borderPaint,
    );

    // Esquina superior derecha
    canvas.drawPath(
      Path()
        ..moveTo(cutOutLeft + cutOutSize - borderLength, cutOutTop)
        ..lineTo(cutOutLeft + cutOutSize - borderRadius, cutOutTop)
        ..moveTo(cutOutLeft + cutOutSize, cutOutTop + borderRadius)
        ..lineTo(cutOutLeft + cutOutSize, cutOutTop + borderLength),
      borderPaint,
    );

    // Esquina inferior izquierda
    canvas.drawPath(
      Path()
        ..moveTo(cutOutLeft, cutOutTop + cutOutSize - borderLength)
        ..lineTo(cutOutLeft, cutOutTop + cutOutSize - borderRadius)
        ..moveTo(cutOutLeft + borderRadius, cutOutTop + cutOutSize)
        ..lineTo(cutOutLeft + borderLength, cutOutTop + cutOutSize),
      borderPaint,
    );

    // Esquina inferior derecha
    canvas.drawPath(
      Path()
        ..moveTo(cutOutLeft + cutOutSize, cutOutTop + cutOutSize - borderLength)
        ..lineTo(cutOutLeft + cutOutSize, cutOutTop + cutOutSize - borderRadius)
        ..moveTo(cutOutLeft + cutOutSize - borderRadius, cutOutTop + cutOutSize)
        ..lineTo(cutOutLeft + cutOutSize - borderLength, cutOutTop + cutOutSize),
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
