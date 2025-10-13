import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/catalog/widgets/showcase_scaffold.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_text_field.dart';
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
  final _emailCtrl = TextEditingController();
  final _passCtrl  = TextEditingController();
  bool _obscured = true;
  String? _emailError;
  String? _passError;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _validar() {
    setState(() {
      _emailError = _emailCtrl.text.contains('@') ? null : 'Email no válido';
      _passError  = _passCtrl.text.length >= 8 ? null : 'Mínimo 8 caracteres';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Validación ejecutada')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return ShowcaseScaffold(
      title: 'Inputs de Texto',
      modoOscuro: widget.modoOscuro,
      onCambioModoOscuro: widget.onCambioModoOscuro,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Email', style: t.titleSmall),
          const SizedBox(height: 8),
          AppTextField.email(
            controller: _emailCtrl,
            errorText: _emailError,
            onSubmitted: (_) => _validar(),
          ),
          const SizedBox(height: 20),

          Text('Contraseña (toggle mostrar/ocultar)', style: t.titleSmall),
          const SizedBox(height: 8),
          AppTextField.password(
            controller: _passCtrl,
            isObscured: _obscured,
            onToggleObscure: () => setState(() => _obscured = !_obscured),
            errorText: _passError,
            onSubmitted: (_) => _validar(),
          ),
          const SizedBox(height: 20),

          Text('Multilínea', style: t.titleSmall),
          const SizedBox(height: 8),
          const AppTextField.multiline(
          ),
          const SizedBox(height: 32),

          AppButton(
            label: 'Validar inputs',
            onPressed: _validar,
            size: AppButtonSize.lg,
            variant: AppButtonVariant.primary,
          ),
        ],
      ),
    );
  }
}
