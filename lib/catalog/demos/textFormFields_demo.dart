import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/catalog/widgets/showcase_scaffold.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_text_form_field.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_button.dart';

class TextFieldsDemo extends StatefulWidget {
  final bool modoOscuro;
  final ValueChanged<bool> onCambioModoOscuro;

  const TextFieldsDemo({
    super.key,
    required this.modoOscuro,
    required this.onCambioModoOscuro,
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
    if (value.isEmpty) return 'Introduce tu email';
    if (!value.contains('@') || !value.contains('.')) return 'Email no válido';
    return null;
  }

  String? _validatePassword(String? v) {
    final value = v ?? '';
    if (value.isEmpty) return 'Introduce tu contraseña';
    if (value.length < 8) return 'Mínimo 8 caracteres';
    return null;
  }

  String? _validateDescription(String? v) {
    final value = (v ?? '').trim();
    if (value.isEmpty) return 'Introduce una descripción';
    return null;
  }

  // Funciones

  void _toggleObscure() => setState(() => _obscured = !_obscured);

  void _submit() {
    final ok = _formKey.currentState?.validate() ?? false;
    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Revisa los campos')),
      );
      return;
    }
    /// Lógica real de login
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Validado correctamente')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return ShowcaseScaffold(
      title: 'Inputs de Texto',
      backgroundColor: scheme.primaryContainer,
      modoOscuro: widget.modoOscuro,
      onCambioModoOscuro: widget.onCambioModoOscuro,
      body: Form( // Gestión de validación y estado de los campos (TextFormField)
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('Email', style: t.titleSmall),
            const SizedBox(height: 12),
            AppTextFormField(
              variant: AppTextFieldVariant.email,
              controller: _emailCtrl,
              validator: _validateEmail,
            ),
            const SizedBox(height: 24),

            Text('Contraseña (toggle mostrar/ocultar)', style: t.titleSmall),
            const SizedBox(height: 12),
            AppTextFormField(
              variant: AppTextFieldVariant.password,
              controller: _passCtrl,
              isObscured: _obscured,
              onToggleObscure: _toggleObscure,
              validator: _validatePassword,
            ),
            const SizedBox(height: 24),

            Text('Multilínea', style: t.titleSmall),
            const SizedBox(height: 12),
            AppTextFormField(
              variant: AppTextFieldVariant.multiline,
              controller: _descCtrl,
              validator: _validateDescription,
            ),
            const SizedBox(height: 34),

            AppButton(
              label: 'Validar inputs',
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
