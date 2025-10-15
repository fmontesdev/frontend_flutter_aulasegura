import 'package:flutter/material.dart';

enum AppTextFieldVariant { email, password, text, number, multiline }

class AppTextFormField extends StatelessWidget {
  final AppTextFieldVariant? variant;

  final String? label;
  final String? hintText;
  final IconData? leadingIcon;
  final bool enabled;

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Iterable<String>? autofillHints;

  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldSetter<String>? onSaved;

  final Color? labelColor;          // color del label “quieto”
  final Color? floatingLabelColor;  // color del label flotante
  final Color? textColor;           // color del texto que escribe el usuario

  final bool? isObscured;
  final VoidCallback? onToggleObscure;

  const AppTextFormField({
    super.key,
    required this.variant,
    this.label,
    this.hintText,
    this.leadingIcon,
    this.enabled = true,
    this.controller,
    this.focusNode,
    this.autofillHints,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.onSaved,
    this.labelColor,
    this.floatingLabelColor,
    this.textColor,
    this.isObscured,
    this.onToggleObscure,
  });

  // ---------- Configuración por variante ----------

  ({String? label, String? hintText,TextInputType keyboard, TextInputAction action, IconData? icon, Iterable<String>? hints})
  _tokensForVariant(AppTextFieldVariant? v) {
    switch (v) {
      case AppTextFieldVariant.email:
        return (
          label: 'Introduce tu email',
          hintText: 'ejemplo@dominio.com',
          keyboard: TextInputType.emailAddress,
          action: TextInputAction.next,
          icon: Icons.alternate_email,
          hints: const [AutofillHints.email]
        );
      case AppTextFieldVariant.password:
        return (
          label: 'Introduce tu contraseña',
          hintText: null,
          keyboard: TextInputType.text,
          action: TextInputAction.next,
          icon: Icons.lock_outline,
          hints: const [AutofillHints.password]
        );
      case AppTextFieldVariant.number:
        return (
          label: null,
          hintText: null,
          keyboard: TextInputType.number,
          action: TextInputAction.next,
          icon: Icons.pin,
          hints: null
        );
      case AppTextFieldVariant.multiline:
        return (
          label: 'Descripción',
          hintText: 'Añade una descripción…',
          keyboard: TextInputType.multiline,
          action: TextInputAction.newline,
          icon: null,
          hints: null
        );
      case AppTextFieldVariant.text:
      default:
        return (
          label: null,
          hintText: null,
          keyboard: TextInputType.text,
          action: TextInputAction.next,
          icon: Icons.text_fields,
          hints: null
        );
    }
  }

  // ---------- Colores por variante ----------

  ({Color fill, Color borderEnabled, Color borderFocused, Color icon, Color label, Color? floatingLabel, Color? text})
  _colorsForVariant(ColorScheme scheme, AppTextFieldVariant? v) {
    switch (v) {
      case AppTextFieldVariant.email:
      case AppTextFieldVariant.password:
        return (
          fill: scheme.tertiary,
          borderEnabled: scheme.tertiary,
          borderFocused: scheme.onTertiary,
          icon: scheme.onTertiary,
          label: scheme.primary,
          floatingLabel: scheme.onPrimary,
          text: null
        );
      case AppTextFieldVariant.number:
      case AppTextFieldVariant.multiline:
      case AppTextFieldVariant.text:
      default:
        return (
          fill: scheme.surface,
          borderEnabled: scheme.secondary,
          borderFocused: scheme.primaryContainer,
          icon: scheme.onSurfaceVariant,
          label: scheme.secondary,
          floatingLabel: null,
          text: null
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    // Variantes
    final tokens = _tokensForVariant(variant);
    final tone = _colorsForVariant(scheme, variant);

    final obscure = (variant == AppTextFieldVariant.password) ? (isObscured ?? true) : false;
    final showToggle = variant == AppTextFieldVariant.password && isObscured != null && onToggleObscure != null;

    // estilo de texto del input (aplica override si llega)
    final inputTextStyle = (textTheme.bodyLarge ?? const TextStyle()).copyWith(
      color: textColor ?? tone.text // si textColor == null, usa el de la variante
    );

    return FormField<String>(
      validator: validator,
      onSaved: onSaved,
      builder: (state) {
        final hasError = state.hasError && (state.errorText?.isNotEmpty ?? false);

        // color final del floating label:
        final Color floatingColor = hasError
            ? scheme.error
            : (floatingLabelColor
                ?? tone.floatingLabel
                // ?? (theme.inputDecorationTheme.floatingLabelStyle?.color)
                ?? tone.label
              );

        return TextField(
          controller: controller,
          focusNode: focusNode,
          enabled: enabled,
          keyboardType: tokens.keyboard,
          textInputAction: tokens.action,
          obscureText: obscure,
          onChanged: (v) { // sincroniza con el FormField para que hasError reaccione
            state.didChange(v);
            onChanged?.call(v);
          },
          onSubmitted: onFieldSubmitted,
          autofillHints: autofillHints ?? tokens.hints,
          maxLines: variant == AppTextFieldVariant.multiline ? null : 1,
          minLines: variant == AppTextFieldVariant.multiline ? 3 : 1,
          style: inputTextStyle,
          decoration: InputDecoration(
            labelText: label ?? tokens.label,
            hintText: hintText ?? tokens.hintText,
            errorText: state.errorText,
            filled: true,
            fillColor: tone.fill,
            labelStyle: (const TextStyle()).copyWith(
              fontWeight: FontWeight.w500,
              color: labelColor ?? tone.label,
            ),
            floatingLabelStyle: (const TextStyle()).copyWith(
                fontWeight: FontWeight.w500,
                color: floatingColor
              ),
            prefixIcon: (leadingIcon ?? tokens.icon) != null
              ? Icon(leadingIcon ?? tokens.icon, color: tone.icon)
              : null,
            suffixIcon: showToggle
                ? IconButton(
                    tooltip: obscure ? 'Mostrar' : 'Ocultar',
                    onPressed: onToggleObscure,
                    icon: Icon(obscure ? Icons.visibility : Icons.visibility_off, color: tone.icon),
                  )
                : null,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(25)),
              borderSide: BorderSide(color: tone.borderEnabled, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(25)),
              borderSide: BorderSide(color: tone.borderFocused, width: 1.6),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(25)),
              borderSide: BorderSide(color: scheme.error, width: 1.2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(25)),
              borderSide: BorderSide(color: scheme.error, width: 1.6),
            ),
            errorStyle: TextStyle(
              color: scheme.error,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      },
    );
  }
}

