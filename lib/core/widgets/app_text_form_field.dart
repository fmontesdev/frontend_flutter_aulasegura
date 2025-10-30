import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';
import 'package:frontend_flutter_aulasegura/l10n/app_localizations.dart';

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
  final Color? hintColor;           // color del hint (placeholder)

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
    this.hintColor,
    this.isObscured,
    this.onToggleObscure,
  });

  // ---------- Configuración por variante ----------

  ({String? label, String? hintText,TextInputType keyboard, TextInputAction action, IconData? icon, Iterable<String>? hints})
  _tokensForVariant(AppTextFieldVariant? v, AppLocalizations l10n) {
    switch (v) {
      case AppTextFieldVariant.email:
        return (
          label: l10n.enterEmail, //? Etiqueta del campo de email con internacionalización
          hintText: l10n.emailHintText, //? HintText del campo de email con internacionalización
          keyboard: TextInputType.emailAddress,
          action: TextInputAction.next,
          icon: Icons.alternate_email,
          hints: const [AutofillHints.email]
        );
      case AppTextFieldVariant.password:
        return (
          label: l10n.enterPassword, //? Etiqueta del campo de contraseña con internacionalización
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
          label: l10n.descriptionLabel, //? Etiqueta del campo de descripción con internacionalización
          hintText: l10n.descriptionHintText, //? HintText del campo de descripción con internacionalización
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

  ({Color fill, Color borderEnabled, Color borderFocused, Color icon, Color label, Color? floatingLabel, Color? text, Color? hint})
  _colorsForVariant(ColorScheme scheme, AppTextFieldVariant? v) {
    switch (v) {
      case AppTextFieldVariant.email:
      case AppTextFieldVariant.password:
        return (
          fill: scheme.quatertiary,
          borderEnabled: scheme.quatertiary,
          borderFocused: scheme.onPrimary,
          icon: scheme.onPrimary,
          label: scheme.primary,
          floatingLabel: scheme.onPrimary,
          text: scheme.onQuatertiary,
          hint: scheme.darkGrey,
        );
      case AppTextFieldVariant.number:
      case AppTextFieldVariant.multiline:
      case AppTextFieldVariant.text:
      default:
        return (
          fill: scheme.surface,
          borderEnabled: scheme.secondary,
          borderFocused: scheme.highlight,
          icon: scheme.primary,
          label: scheme.secondary,
          floatingLabel: null,
          text: null,
          hint: scheme.darkGrey,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final textTheme = theme.textTheme;
        final l10n = AppLocalizations.of(context)!;

    // Variantes
    final tokens = _tokensForVariant(variant, l10n);
    final tone = _colorsForVariant(scheme, variant);

    final obscure = (variant == AppTextFieldVariant.password) ? (isObscured ?? true) : false;
    final showToggle = variant == AppTextFieldVariant.password && isObscured != null && onToggleObscure != null;

    // estilo de texto del input (aplica override si llega)
    final inputTextStyle = (textTheme.bodyLarge ?? const TextStyle()).copyWith(
      color: textColor ?? tone.text, // si textColor == null, usa el de la variante
      fontSize: 17,
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
            labelStyle: (const TextStyle()).copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 17,
              color: labelColor ?? tone.label,
            ),
            hintText: hintText ?? tokens.hintText,
            hintStyle: TextStyle(
              color: hintColor ?? tone.hint,
            ),
            floatingLabelStyle: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 21,
              color: floatingColor,
            ),
            errorText: state.errorText,
            errorStyle: TextStyle(
              color: scheme.error,
              fontSize: 14.5,
              fontWeight: FontWeight.w600,
            ),
            filled: true,
            fillColor: tone.fill,
            hoverColor: scheme.highlight.withValues(alpha: 0.025),
            prefixIcon: (leadingIcon ?? tokens.icon) != null
              ? Icon(leadingIcon ?? tokens.icon, color: tone.icon)
              : null,
            suffixIcon: showToggle
                ? IconButton(
                    tooltip: obscure ? l10n.show : l10n.hide, //? Tooltip para toggle visibilidad con internacionalización
                    onPressed: onToggleObscure,
                    icon: Icon(obscure ? Icons.visibility : Icons.visibility_off, color: tone.icon),
                  )
                : null,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(40)),
              borderSide: BorderSide(color: tone.borderEnabled, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(40)),
              borderSide: BorderSide(color: tone.borderFocused, width: 1.6),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(40)),
              borderSide: BorderSide(color: scheme.error, width: 1.2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(40)),
              borderSide: BorderSide(color: scheme.error, width: 1.6),
            ),
          ),
        );
      },
    );
  }
}