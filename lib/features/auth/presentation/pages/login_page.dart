import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_text_form_field.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_link.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_button.dart';
import 'package:frontend_flutter_aulasegura/features/home/presentation/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>(); // Para gestionar el estado del formulario
  final _emailCtrl = TextEditingController(); // Controlador para el campo email
  final _passCtrl  = TextEditingController(); // Controlador para el campo password
  bool _obscured = true; // Para toggle de visibilidad de la contraseña

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
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

  // Funciones

  void _toggleObscure() => setState(() => _obscured = !_obscured);

  void _forgotPassword() {
    /// Navegar a recuperación
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Recuperar contraseña')),
    );
  }

  void _submit() {
    final ok = _formKey.currentState?.validate() ?? false;
    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Revisa los campos')),
      );
      return;
    }
    /// Lógica real de login
    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(content: Text('Login enviado')),
    // );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.primary,
      body: SafeArea( // Añade padding automático en zonas de notch, etc.
        child: LayoutBuilder( // Para adaptar el layout según el tamaño
          builder: (context, constraints) {
            // Contenedor máx. para tablets/escritorio
            final maxW = constraints.maxWidth < 560 ? constraints.maxWidth : 480.0;

            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: maxW), // Ancho max. para que no estire mucho en pantallas anchas
                child: SingleChildScrollView( // Scroll si no cabe en vertical para evitar overflow (keyboard, pantallas pequeñas...)
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  child: Form( // Gestión de validación y estado de los campos (TextFormField)
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Logo
                        Image.asset(
                          'assets/images/logo.png',
                          width: 170,
                          height: 170,
                          fit: BoxFit.contain,
                          semanticLabel: 'Logo AulaSegura',
                        ),
                        const SizedBox(height: 10),

                        // Nombre app
                        Text(
                          'AulaSegura',
                          style: t.displayLarge?.copyWith(
                            color: scheme.onPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 85),

                        // Email
                        AppTextFormField(
                          variant: AppTextFieldVariant.email,
                          controller: _emailCtrl,
                          validator: _validateEmail,
                        ),
                        const SizedBox(height: 20),

                        // Password con toggle
                        AppTextFormField(
                          variant: AppTextFieldVariant.password,
                          controller: _passCtrl,
                          isObscured: _obscured,
                          onToggleObscure: _toggleObscure,
                          validator: _validatePassword,
                          ),
                        const SizedBox(height: 14),

                        // Link "Se te olvidó la contraseña?"
                        AppLink(
                          text: '¿Se te olvidó la contraseña?',
                          onTap: _forgotPassword,
                          size: AppLinkSize.lg,
                          align: AppLinkAlign.end,
                          color: scheme.onPrimary,
                          // hoverColor: Theme.of(context).colorScheme.tertiary,
                          // hoverUnderlineColor: Theme.of(context).colorScheme.tertiary,
                          // hoverUnderlineThickness: 1.0,
                        ),
                        const SizedBox(height: 65),

                        // Botón login
                        AppButton(
                          label: 'Inicia sesión',
                          onPressed: _submit,
                          size: AppButtonSize.lg,
                          variant: AppButtonVariant.secondary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
