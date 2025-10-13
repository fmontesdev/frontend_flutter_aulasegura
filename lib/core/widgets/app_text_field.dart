import 'package:flutter/material.dart';

enum AppTextFieldVariant { email, password, text, number, multiline }

class AppTextField extends StatelessWidget {
  final AppTextFieldVariant? variant;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  final String label;
  final String? hintText;
  final String? errorText;
  final bool enabled;

  final IconData? leadingIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  final Iterable<String>? autofillHints;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  final bool? isObscured;
  final VoidCallback? onToggleObscure;

  // ---------- Constructores por variante ----------

  // Email
  const AppTextField.email({
    super.key,
    String? label,
    this.controller,
    this.focusNode,
    String? hintText,
    this.errorText,
    this.enabled = true,
    IconData? leadingIcon,
    Iterable<String>? autofillHints,
    this.onChanged,
    this.onSubmitted,
  })  : variant = AppTextFieldVariant.email,
        label = label ?? 'Email',
        hintText = hintText ?? 'tu@correo.com',
        leadingIcon = leadingIcon ?? Icons.alternate_email,
        keyboardType = TextInputType.emailAddress,
        textInputAction = TextInputAction.next,
        autofillHints = autofillHints ?? const [AutofillHints.email],
        isObscured = null,
        onToggleObscure = null;

  // Password
  const AppTextField.password({
    super.key,
    String? label,
    required bool this.isObscured,
    required VoidCallback this.onToggleObscure,
    this.controller,
    this.focusNode,
    String? hintText,
    this.errorText,
    this.enabled = true,
    IconData? leadingIcon,
    this.onChanged,
    this.onSubmitted,
    Iterable<String>? autofillHints,
  })  : variant = AppTextFieldVariant.password,
        label = label ?? 'Contraseña',
        hintText = hintText ?? '',
        leadingIcon = leadingIcon ?? Icons.lock_outline,
        keyboardType = TextInputType.text,
        textInputAction = TextInputAction.next,
        autofillHints = autofillHints ?? const [AutofillHints.password];

  // Text
  const AppTextField.text({
    super.key,
    required this.label,
    this.controller,
    this.focusNode,
    String? hintText,
    this.errorText,
    this.enabled = true,
    IconData? leadingIcon,
    this.onChanged,
    this.onSubmitted,
    this.autofillHints,
  })  : variant = AppTextFieldVariant.text,
        hintText = hintText,
        leadingIcon = leadingIcon,
        keyboardType = TextInputType.text,
        textInputAction = TextInputAction.next,
        isObscured = null,
        onToggleObscure = null;

  // Number
  const AppTextField.number({
    super.key,
    required this.label,
    this.controller,
    this.focusNode,
    String? hintText,
    this.errorText,
    this.enabled = true,
    IconData? leadingIcon,
    this.onChanged,
    this.onSubmitted,
    this.autofillHints,
  })  : variant = AppTextFieldVariant.number,
        hintText = hintText,
        leadingIcon = leadingIcon ?? Icons.pin,
        keyboardType = TextInputType.number,
        textInputAction = TextInputAction.next,
        isObscured = null,
        onToggleObscure = null;

  // Multiline
  const AppTextField.multiline({
    super.key,
    String? label,
    this.controller,
    this.focusNode,
    String? hintText,
    this.errorText,
    this.enabled = true,
    IconData? leadingIcon,
    this.onChanged,
    this.onSubmitted,
    this.autofillHints,
  })  : variant = AppTextFieldVariant.multiline,
        label = label ?? 'Descripción',
        hintText = hintText ?? 'Añade una descripción…',
        leadingIcon = leadingIcon,
        keyboardType = TextInputType.multiline,
        textInputAction = TextInputAction.newline,
        isObscured = null,
        onToggleObscure = null;

  // ---------- Helper de colores por variante ----------

  _TFColors _colorsForVariant(ColorScheme scheme, AppTextFieldVariant? v, {required bool enabled}) {
    Color dim(Color c) => enabled ? c : c.withValues(alpha: 0.38); // atenuar si está deshabilitado

    switch (v) {
      case AppTextFieldVariant.email:
        return _TFColors(
          fill: dim(scheme.surface),
          borderEnabled: dim(scheme.outline),
          borderFocused: dim(scheme.primary),
          icon: dim(scheme.secondary),
          label: dim(scheme.onSurfaceVariant),
        );
      case AppTextFieldVariant.password:
        return _TFColors(
          fill: dim(scheme.surface),
          borderEnabled: dim(scheme.outline),
          borderFocused: dim(scheme.secondary),
          icon: dim(scheme.secondary),
          label: dim(scheme.onSurfaceVariant),
        );
      case AppTextFieldVariant.number:
        return _TFColors(
          fill: dim(scheme.surface),
          borderEnabled: dim(scheme.outline),
          borderFocused: dim(scheme.tertiary),
          icon: dim(scheme.tertiary),
          label: dim(scheme.onSurfaceVariant),
        );
      case AppTextFieldVariant.multiline:
        return _TFColors(
          fill: dim(scheme.surface),
          borderEnabled: dim(scheme.outline),
          borderFocused: dim(scheme.primaryContainer),
          icon: dim(scheme.onSurfaceVariant),
          label: dim(scheme.onSurfaceVariant),
        );
      case AppTextFieldVariant.text:
      default:
        return _TFColors(
          fill: dim(scheme.surface),
          borderEnabled: dim(scheme.outline),
          borderFocused: dim(scheme.primary),
          icon: dim(scheme.onSurfaceVariant),
          label: dim(scheme.onSurfaceVariant),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final showToggle = (variant == AppTextFieldVariant.password) &&
        isObscured != null && onToggleObscure != null;

    final obscure = (variant == AppTextFieldVariant.password) ? (isObscured ?? true) : false;

    // 🎨 colores por variante
    final tone = _colorsForVariant(scheme, variant, enabled: enabled);

    return TextField(
      controller: controller,
      focusNode: focusNode,
      enabled: enabled,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscure,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      autofillHints: autofillHints,
      maxLines: variant == AppTextFieldVariant.multiline ? null : 1,
      minLines: variant == AppTextFieldVariant.multiline ? 3 : 1,
      style: textTheme.bodyLarge,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        errorText: errorText,
        labelStyle: TextStyle(color: tone.label),
        prefixIcon: leadingIcon != null ? Icon(leadingIcon, color: tone.icon) : null,
        suffixIcon: showToggle
            ? IconButton(
                tooltip: obscure ? 'Mostrar' : 'Ocultar',
                onPressed: onToggleObscure,
                icon: Icon(obscure ? Icons.visibility : Icons.visibility_off, color: tone.icon),
              )
            : null,
        filled: true,
        fillColor: tone.fill,
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          borderSide: BorderSide(color: tone.borderFocused, width: 1.6),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          borderSide: BorderSide(color: tone.borderEnabled, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          borderSide: BorderSide(color: scheme.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          borderSide: BorderSide(color: scheme.error, width: 1.6),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      ),
    );
  }
}

class _TFColors {
  final Color fill;
  final Color borderEnabled;
  final Color borderFocused;
  final Color icon;
  final Color label;
  const _TFColors({
    required this.fill,
    required this.borderEnabled,
    required this.borderFocused,
    required this.icon,
    required this.label,
  });
}

