import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/core/l10n/app_localizations.dart';
import 'package:frontend_flutter_aulasegura/catalog/widgets/showcase_scaffold.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_text_form_field.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_button.dart';

class TextFieldsDemo extends StatefulWidget {
  final bool darkMode;
  final ValueChanged<bool> onToggleDarkMode;

  const TextFieldsDemo({
    super.key,
    required this.darkMode,
    required this.onToggleDarkMode,
  });

  @override
  State<TextFieldsDemo> createState() => _TextFieldsDemoState();
}

class _TextFieldsDemoState extends State<TextFieldsDemo> {
  final _formKey = GlobalKey<FormState>(); // Para gestionar el estado del formulario
  final _emailCtrl = TextEditingController(); // Controlador para el campo email
  final _passCtrl  = TextEditingController(); // Controlador para el campo password
  final _descCtrl  = TextEditingController(); // Controlador para el campo descripción
  bool _obscured = true; // Para toggle de visibilidad de la contraseña

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  // Validadores

  String? _validateEmail(String? v) {
    final value = (v ?? '').trim();
    final l10n = AppLocalizations.of(context)!;
    if (value.isEmpty) return l10n.enterYourEmail;
    if (!value.contains('@') || !value.contains('.')) return l10n.invalidEmail;
    return null;
  }

  String? _validatePassword(String? v) {
    final value = v ?? '';
    final l10n = AppLocalizations.of(context)!;
    if (value.isEmpty) return l10n.enterYourPassword;
    if (value.length < 8) return l10n.minimum8Characters;
    return null;
  }

  String? _validateDescription(String? v) {
    final value = (v ?? '').trim();
    final l10n = AppLocalizations.of(context)!;
    if (value.isEmpty) return l10n.enterDescription;
    return null;
  }

  // Funciones

  void _toggleObscure() => setState(() => _obscured = !_obscured);

  void _submit() {
    final l10n = AppLocalizations.of(context)!;
    final ok = _formKey.currentState?.validate() ?? false;
    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.reviewFields)),
      );
      return;
    }
    /// Lógica real de login
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.validatedCorrectly)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return ShowcaseScaffold(
      title: l10n.textInputs,
      backgroundColor: scheme.primaryContainer,
      darkMode: widget.darkMode,
      onToggleDarkMode: widget.onToggleDarkMode,
      body: Form( // Gestión de validación y estado de los campos (TextFormField)
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(l10n.email, style: t.titleSmall),
            const SizedBox(height: 12),
            AppTextFormField(
              variant: AppTextFieldVariant.email,
              controller: _emailCtrl,
              validator: _validateEmail,
            ),
            const SizedBox(height: 20),

            Text(l10n.passwordToggleShowHide, style: t.titleSmall),
            const SizedBox(height: 12),
            AppTextFormField(
              variant: AppTextFieldVariant.password,
              controller: _passCtrl,
              isObscured: _obscured,
              onToggleObscure: _toggleObscure,
              validator: _validatePassword,
            ),
            const SizedBox(height: 20),

            Text(l10n.multiline, style: t.titleSmall),
            const SizedBox(height: 12),
            AppTextFormField(
              variant: AppTextFieldVariant.multiline,
              controller: _descCtrl,
              validator: _validateDescription,
            ),
            const SizedBox(height: 34),

            AppButton(
              label: l10n.validateInputs,
              onPressed: _submit,
              size: AppButtonSize.lg,
              variant: AppButtonVariant.secondary,
            ),
          ],
        ),
      ),
    );
  }
}
