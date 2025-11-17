import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_text_form_field.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_link.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_button.dart';
import 'package:frontend_flutter_aulasegura/features/auth/presentation/providers/auth_providers.dart';
import 'package:frontend_flutter_aulasegura/core/l10n/app_localizations.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
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

  //* Validadores

  String? validateEmail(String? v, AppLocalizations l10n) {
    final value = (v ?? '').trim();
    
    // Verifica si está vacío
    if (value.isEmpty) {
      return l10n.enterEmail; //? Mensaje de ingresar email con internacionalización
    }
    
    // Regex para validar formato de email
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    
    if (!emailRegex.hasMatch(value)) {
      return l10n.emailValidation; //? Mensaje de validación de email con internacionalización
    }
    
    // Verifica que no empiece o termine con punto
    if (value.startsWith('.') || value.endsWith('.')) {
      return l10n.emailValidation;
    }
    
    // Verifica puntos consecutivos
    if (value.contains('..')) {
      return l10n.emailValidation;
    }
    
    return null;
  }

  String? validatePassword(String? v, AppLocalizations l10n) {
    final value = v ?? '';
    
    // Verifica si está vacío
    if (value.isEmpty) {
      return l10n.enterPassword; //? Mensaje de ingresar contraseña con internacionalización
    }
    
    // Regex que verifica que contenga al menos una mayúscula, una minúscula, un número y min. 8 caracteres
    final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{8,}$');
    
    if (!passwordRegex.hasMatch(value)) {
      return l10n.passwordValidation; //? Mensaje de validación de contraseña con internacionalización
    }
    
    return null;
  }

  //* Funciones

  void toggleObscure() => setState(() => _obscured = !_obscured);

  void forgotPassword(AppLocalizations l10n) {
    /// Navegar a recuperación
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.forgotPassword)), //? Mensaje de recuperar contraseña con internacionalización
    );
  }

  Future<void> submit(AppLocalizations l10n) async {
    final ok = _formKey.currentState?.validate() ?? false;
    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.checkFields)), //? Mensaje de revisar los campos con internacionalización
      );
      return;
    }

    try {
      await ref
        .read(authProvider.notifier)
        .signIn(_emailCtrl.text.trim(), _passCtrl.text);

      if (!mounted) return;

      // Prefetch del avatar del usuario para que cargue rápido en home
      final user = ref.read(authProvider).value;
      if (user != null) {
        final base = dotenv.env['IMAGE_SERVER_URL'] ?? 'http://localhost:8090';
        final url  = '$base/${user.avatar}';
        final provider = CachedNetworkImageProvider(url);
        // Descarga y decodifica en caché la imagen
        await precacheImage(provider, context);

        if (!mounted) return;
      }

      GoRouter.of(context).go('/home');
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.loginError(error.toString()))), //? Mensaje de error al iniciar sesión con internacionalización
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

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
                        /// Logo
                        Image.asset(
                          'assets/images/logo.png',
                          width: 170,
                          height: 170,
                          fit: BoxFit.contain,
                          semanticLabel: 'Logo AulaSegura',
                        ),
                        const SizedBox(height: 10),

                        /// Nombre app
                        Text(
                          'AulaSegura',
                          style: t.displayLarge?.copyWith(
                            color: scheme.onPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 85),

                        /// Email
                        AppTextFormField(
                          variant: AppTextFieldVariant.email,
                          controller: _emailCtrl,
                          validator: (value) => validateEmail(value, l10n),
                        ),
                        const SizedBox(height: 22),

                        /// Password con toggle
                        AppTextFormField(
                          variant: AppTextFieldVariant.password,
                          controller: _passCtrl,
                          isObscured: _obscured,
                          onToggleObscure: () => toggleObscure(),
                          validator: (value) => validatePassword(value, l10n),
                          ),
                        const SizedBox(height: 14),

                        /// Link "Se te olvidó la contraseña?"
                        AppLink(
                          text: l10n.forgotPassword, //? Mensaje "¿Se te olvidó la contraseña?" con internacionalización
                          onTap: () => forgotPassword(l10n),
                          size: AppLinkSize.lg,
                          align: AppLinkAlign.end,
                          color: scheme.onPrimary,
                          // hoverColor: Theme.of(context).colorScheme.tertiary,
                          // hoverUnderlineColor: Theme.of(context).colorScheme.tertiary,
                          // hoverUnderlineThickness: 1.0,
                        ),
                        const SizedBox(height: 65),

                        /// Botón login
                        AppButton(
                          label: l10n.login, //? Mensaje del botón "Inicia sesión" con internacionalización
                          onPressed: () => submit(l10n),
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