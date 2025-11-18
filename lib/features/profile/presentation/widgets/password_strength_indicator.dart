import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';
import 'package:frontend_flutter_aulasegura/core/l10n/app_localizations.dart';

//* Widget que muestra un indicador visual de la fortaleza de la contraseña
class PasswordStrengthIndicator extends StatelessWidget {
  final String password; // El texto de la contraseña que se está evaluando

  const PasswordStrengthIndicator({
    super.key,
    required this.password,
  });

  /// Calcula la fortaleza de la contraseña
  String _calculateStrength() {
    if (password.length < 8) {
      return 'weak';
    } else if (password.length < 12) {
      final hasUppercase = password.contains(RegExp(r'[A-Z]'));
      final hasLowercase = password.contains(RegExp(r'[a-z]'));
      final hasDigits = password.contains(RegExp(r'[0-9]'));
      final hasSpecialChars = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
      
      final criteria = [hasUppercase, hasLowercase, hasDigits, hasSpecialChars].where((e) => e).length;
      
      return criteria >= 3 ? 'medium' : 'weak';
    } else {
      final hasUppercase = password.contains(RegExp(r'[A-Z]'));
      final hasLowercase = password.contains(RegExp(r'[a-z]'));
      final hasDigits = password.contains(RegExp(r'[0-9]'));
      final hasSpecialChars = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
      
      final criteria = [hasUppercase, hasLowercase, hasDigits, hasSpecialChars].where((e) => e).length;
      
      return criteria >= 3 ? 'strong' : 'medium';
    }
  }

  /// Obtiene el color según la fortaleza
  Color _getStrengthColor(ColorScheme scheme, String strength) {
    switch (strength) {
      case 'weak':
        return scheme.error;
      case 'medium':
        return scheme.warning;
      case 'strong':
        return scheme.success;
      default:
        return scheme.error;
    }
  }

  /// Obtiene el ancho del indicador según la fortaleza
  double _getStrengthWidth(String strength) {
    switch (strength) {
      case 'weak':
        return 0.33;
      case 'medium':
        return 0.66;
      case 'strong':
        return 1.0;
      default:
        return 0.33;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final text = theme.textTheme;
    final l10n = AppLocalizations.of(context)!;

    if (password.isEmpty) {
      return const SizedBox.shrink();
    }

    final strength = _calculateStrength();
    final color = _getStrengthColor(scheme, strength);
    final widthFactor = _getStrengthWidth(strength);

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 6,
                decoration: BoxDecoration(
                  color: scheme.surface,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: widthFactor,
                  child: Container(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              l10n.passwordStrength(strength),
              style: text.bodyMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
      ],
    );
  }
}
