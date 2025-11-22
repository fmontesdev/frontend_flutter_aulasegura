import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:frontend_flutter_aulasegura/features/access/presentation/providers/access_providers.dart';
import 'package:frontend_flutter_aulasegura/features/access/domain/entities/access_check.dart';
import 'package:frontend_flutter_aulasegura/core/l10n/app_localizations.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_pill.dart';
import 'package:intl/intl.dart';

/// BottomSheet que muestra el resultado del acceso QR
class QrAccessResultBottomSheet extends ConsumerWidget {
  final VoidCallback onClose;

  const QrAccessResultBottomSheet({
    super.key,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;
    final asyncValue = ref.watch(qrAccessProvider);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: asyncValue.when(
          loading: () => _buildLoading(l10n),
          error: (error, _) => _buildError(context, scheme, l10n, error.toString()),
          data: (accessCheck) {
            if (accessCheck == null) return const SizedBox.shrink();
            
            return accessCheck.accessStatus == 'allowed'
                ? _buildSuccess(context, scheme, l10n, accessCheck)
                : _buildDenied(context, scheme, l10n, accessCheck);
          },
        ),
      ),
    );
  }

  Widget _buildLoading(AppLocalizations l10n) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircularProgressIndicator(),
        const SizedBox(height: 24),
        Text(
          l10n.validatingAccess,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSuccess(
    BuildContext context,
    ColorScheme scheme,
    AppLocalizations l10n,
    AccessCheck accessCheck,
  ) {
    final permission = accessCheck.permission;

    // Auto-cierre después de 4 segundos
    Future.delayed(const Duration(seconds: 4), () {
      if (context.mounted) {
        onClose();
      }
    });

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Animación de checkmark con Lottie
        SizedBox(
          width: 120,
          height: 120,
          child: Lottie.asset(
            'assets/animations/success.json',
            repeat: false,
          ),
        ),
        Text(
          l10n.accessGranted,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 24),

        // Información simplificada de acceso
        if (permission != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
              // Aula
              AppPill(
                variant: AppPillVariant.quatertiary,
                size: AppPillSize.xl,
                icon: Icons.location_on_outlined,
                label: '${permission.room.name} ${permission.room.roomCode}',
              ),
              const SizedBox(width: 12),

              // Fecha y hora
              AppPill(
                variant: AppPillVariant.quatertiary,
                size: AppPillSize.xl,
                icon: Icons.access_time,
                label: DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now()),
              ),
            ],
          )
        ],
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDenied(
    BuildContext context,
    ColorScheme scheme,
    AppLocalizations l10n,
    AccessCheck accessCheck,
  ) {
    // Auto-cierre después de 4 segundos
    Future.delayed(const Duration(seconds: 4), () {
      if (context.mounted) {
        onClose();
      }
    });

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Animación de X con Lottie
        SizedBox(
          width: 120,
          height: 120,
          child: Lottie.asset(
            'assets/animations/error.json',
            repeat: false,
          ),
        ),
        Text(
          l10n.accessDenied,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: scheme.error,
          ),
        ),
        const SizedBox(height: 24),

        Center(
          child: AppPill(
            variant: AppPillVariant.quatertiary,
            size: AppPillSize.xl,
            label: l10n.accessDenialReason(accessCheck.reasonStatus!.replaceAll(' ', '_')),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildError(
    BuildContext context,
    ColorScheme scheme,
    AppLocalizations l10n,
    String errorMessage,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.error_outline,
          size: 64,
          color: scheme.error,
        ),
        const SizedBox(height: 24),
        Text(
          l10n.errorTitle,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: scheme.error,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          errorMessage,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 24),
        FilledButton(
          onPressed: onClose,
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(48),
          ),
          child: Text(l10n.understood),
        ),
      ],
    );
  }
}
