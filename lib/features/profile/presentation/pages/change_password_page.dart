import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend_flutter_aulasegura/features/auth/presentation/providers/auth_providers.dart';
import 'package:frontend_flutter_aulasegura/features/profile/presentation/widgets/requirements_card.dart';
import 'package:frontend_flutter_aulasegura/features/profile/presentation/widgets/password_strength_indicator.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_overlay_scaffold.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_text_form_field.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_button.dart';
import 'package:frontend_flutter_aulasegura/core/l10n/app_localizations.dart';

class ChangePasswordPage extends ConsumerStatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  ConsumerState<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends ConsumerState<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordCtrl = TextEditingController();
  final _newPasswordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();
  // Regex que verifica que contenga al menos una mayúscula, una minúscula, un número y min. 8 caracteres
  final _passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{8,}$');
  
  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _currentPasswordCtrl.dispose();
    _newPasswordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    super.dispose();
  }

  //* Validadores

  String? validateCurrentPassword(String? value, AppLocalizations l10n) {
    // Verifica si está vacío
    if (value == null || value.isEmpty) return l10n.enterPassword;
    
    // Regex que verifica que contenga al menos una mayúscula, una minúscula, un número y min. 8 caracteres
    if (!_passwordRegex.hasMatch(value)) return l10n.passwordValidation;
    
    return null;
  }

  String? validateNewPassword(String? value, AppLocalizations l10n) {
    // Verifica si está vacío
    if (value == null || value.isEmpty) return l10n.enterPassword;
    
    // Regex que verifica que contenga al menos una mayúscula, una minúscula, un número y min. 8 caracteres
    if (!_passwordRegex.hasMatch(value)) return l10n.passwordValidation;
    
    // Verifica que sea diferente a la contraseña actual
    if (value == _currentPasswordCtrl.text) return l10n.newPasswordMustBeDifferent;
    
    return null;
  }

  String? validateConfirmPassword(String? value, AppLocalizations l10n) {
    // Verifica si está vacío
    if (value == null || value.isEmpty) return l10n.enterPassword;
    
    // Verifica que las contraseñas coincidan
    if (value != _newPasswordCtrl.text) return l10n.passwordsDoNotMatch;
    
    return null;
  }

  //* Funciones

  /// Envía el formulario
  Future<void> _submit(AppLocalizations l10n) async {
    final scheme = Theme.of(context).colorScheme;
    final ok = _formKey.currentState?.validate() ?? false;
    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            child: Text(l10n.checkFields),
          ),
          backgroundColor: scheme.primary,
          behavior: SnackBarBehavior.floating, // Evita el solapamiento con otros elementos
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        ),
      );
      return;
    }

    if (_isLoading) return;// Prevenir múltiples envíos
    setState(() => _isLoading = true);

    try {
      await ref.read(authProvider.notifier).changePassword(
        _currentPasswordCtrl.text,
        _newPasswordCtrl.text,
      );

      if (!mounted) return;
      setState(() => _isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            child: Text(l10n.passwordChangedSuccessfully),
          ),
          backgroundColor: scheme.primary,
          behavior: SnackBarBehavior.floating, // Evita el solapamiento con otros elementos
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        ),
      );

      context.pop(); // Volver a la página anterior
    } catch (error) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            child: Text(l10n.changePasswordError(error.toString())),
          ),
          backgroundColor: scheme.primary,
          behavior: SnackBarBehavior.floating, // Evita el solapamiento con otros elementos
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AppOverlayScaffold(
      title: l10n.changePassword,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              
              /// Contraseña actual
              AppTextFormField(
                variant: AppTextFieldVariant.password,
                label: l10n.currentPassword,
                controller: _currentPasswordCtrl,
                isObscured: _obscureCurrentPassword,
                onToggleObscure: () => setState(() => _obscureCurrentPassword = !_obscureCurrentPassword),
                validator: (value) => validateCurrentPassword(value, l10n),
              ),

              const SizedBox(height: 16),

              /// Nueva contraseña
              AppTextFormField(
                variant: AppTextFieldVariant.password,
                label: l10n.newPassword,
                leadingIcon: Icons.lock_reset_outlined,
                controller: _newPasswordCtrl,
                isObscured: _obscureNewPassword,
                onToggleObscure: () => setState(() => _obscureNewPassword = !_obscureNewPassword),
                validator: (value) => validateNewPassword(value, l10n),
                onChanged: (value) => setState(() {}), // Actualiza el widget para reflejar cambios
              ),

              const SizedBox(height: 16),

              /// Indicador de fortaleza de contraseña
              PasswordStrengthIndicator(
                password: _newPasswordCtrl.text,
              ),

              /// Confirmar contraseña
              AppTextFormField(
                variant: AppTextFieldVariant.password,
                label: l10n.confirmPassword,
                leadingIcon: Icons.lock_reset_outlined,
                controller: _confirmPasswordCtrl,
                isObscured: _obscureConfirmPassword,
                onToggleObscure: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                validator: (value) => validateConfirmPassword(value, l10n),
              ),

              const SizedBox(height: 30),

              /// Requisitos de contraseña
              RequirementsCard(
                password: _newPasswordCtrl.text,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: SizedBox(
            width: double.infinity,
            child: AppButton(
              variant: AppButtonVariant.secondary,
              size: AppButtonSize.lg,
              label: _isLoading ? l10n.saving : l10n.saveChanges,
              onPressed: _isLoading ? () {} : () => _submit(l10n),
            ),
          ),
        ),
      ),
    );
  }
}
