import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:frontend_flutter_aulasegura/features/access/presentation/providers/access_providers.dart';
import 'package:frontend_flutter_aulasegura/features/access/presentation/widgets/qr_access_result_bottom_sheet.dart';
import 'package:frontend_flutter_aulasegura/features/access/presentation/widgets/qr_scanner_overlay_painter.dart';
import 'package:frontend_flutter_aulasegura/core/l10n/app_localizations.dart';

/// Página fullscreen para escanear códigos QR
class QrScannerPage extends ConsumerStatefulWidget {
  const QrScannerPage({
    super.key,
  });

  @override
  ConsumerState<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends ConsumerState<QrScannerPage> {
  final MobileScannerController _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    facing: CameraFacing.back,
    torchEnabled: false,
  );

  bool _isProcessing = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) async {
    if (_isProcessing) return;

    final List<Barcode> barcodes = capture.barcodes;
    for (final barcode in barcodes) {
      final String? code = barcode.rawValue;
      if (code != null && code.isNotEmpty) {
        setState(() => _isProcessing = true);

        // Guardar notifier antes de desmontar el widget
        final notifier = ref.read(qrAccessProvider.notifier);

        // Detener el scanner
        await _controller.stop();

        // Procesar el QR (readerCode)
        await notifier.checkAccess(code, 'qr');

        if (mounted) {
          // Transición suave antes de cerrar
          await Future.delayed(const Duration(milliseconds: 300));
          
          if (mounted) {
            // Cerrar scanner con GoRouter y mostrar resultado
            context.pop(); // Cerrar Scanner
            _showResultBottomSheet(notifier);
          }
        }
        break;
      }
    }
  }

  void _showResultBottomSheet(QrAccessNotifier notifier) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      // backgroundColor: Colors.black.withValues(alpha: 0.75),
      builder: (context) => QrAccessResultBottomSheet(
        onClose: () {
          context.pop(); // Cerrar BottomSheet con GoRouter
          notifier.reset();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Cámara scanner
          MobileScanner(
            controller: _controller,
            onDetect: _onDetect,
          ),

          // Overlay con guías visuales
          CustomPaint(
            painter: QrScannerOverlayPainter(
              borderColor: scheme.secondary,
              borderWidth: 3.0,
              borderLength: 40.0,
              borderRadius: 12.0,
              cutOutSize: 300.0,
            ),
            child: const SizedBox.expand(),
          ),

          // Botones superiores
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Botón cerrar
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () {
                          context.pop();
                          ref.read(qrAccessProvider.notifier).reset();
                        },
                      ),
                      // Botón linterna
                      ValueListenableBuilder(
                        valueListenable: _controller,
                        builder: (context, state, child) {
                          final torchState = state.torchState;
                          return IconButton(
                            icon: Icon(
                              torchState == TorchState.on
                                  ? Icons.flash_on
                                  : Icons.flash_off,
                              color: Colors.white,
                            ),
                            onPressed: () => _controller.toggleTorch(),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Instrucción
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      l10n.qrAccess,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Texto inferior
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Text(
              l10n.focusQrCode,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
