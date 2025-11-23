import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:frontend_flutter_aulasegura/core/l10n/app_localizations.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';
import 'package:frontend_flutter_aulasegura/features/auth/domain/entities/user.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_card.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_pill.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_selectable_tile.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_modal_options.dart';
import 'package:frontend_flutter_aulasegura/core/utils/normalize_string.dart';
import 'package:frontend_flutter_aulasegura/core/utils/floating_snackbar.dart';
import 'package:frontend_flutter_aulasegura/features/profile/presentation/providers/avatar_provider.dart';
import 'package:frontend_flutter_aulasegura/features/auth/presentation/providers/auth_providers.dart';

class UserCard extends ConsumerWidget {
  final User user;

  const UserCard({
    super.key,
    required this.user,
  });

  void _showAvatarPicker(BuildContext context, ThemeData theme, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return AppModalOptions(
          title: l10n.changeAvatar,
          options: [
            SelectableTile(
              icon: Icons.camera_alt,
              label: l10n.takePhoto,
              selected: false,
              onTap: () async {
                context.pop();
                await _handleImageSelection(context, ref, isCamera: true);
              },
            ),
            SelectableTile(
              icon: Icons.photo_library,
              label: l10n.selectFromGallery,
              selected: false,
              onTap: () async {
                context.pop();
                await _handleImageSelection(context, ref, isCamera: false);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleImageSelection(BuildContext context, WidgetRef ref, {required bool isCamera}) async {
    final l10n = AppLocalizations.of(context)!;
    final avatarService = ref.read(avatarServiceProvider);

    try {
      // Seleccionar imagen
      final imageFile = isCamera 
          ? await avatarService.pickFromCamera()
          : await avatarService.pickFromGallery();

      if (imageFile == null) return;

      // Actualizar avatar
      await ref.read(avatarUploadProvider).uploadAvatar(imageFile);

      if (!context.mounted) return;
      showFloatingSnackBar(
        context,
        message: l10n.avatarUpdatedSuccessfully,
      );
    } catch (error) {
      if (!context.mounted) return;
      
      // Extrae la clave del error
      final errorKey = error.toString().replaceAll('Exception: ', '');
      
      showFloatingSnackBar(
        context,
        message: l10n.avatarError(errorKey),
        isError: true,
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final text = theme.textTheme;
    final l10n = AppLocalizations.of(context)!;
    final imageServerUrl = dotenv.env['IMAGE_SERVER_URL'] ?? 'http://localhost:8090';
    final authState = ref.watch(authProvider);
    final isLoading = authState.isLoading;

    return AppCard(
      alignment: CrossAxisAlignment.center,
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      children: [
        /// Avatar con botón flotante de edición
        Stack( // Permite superponer el botón sobre el avatar
          children: [

            /// Avatar
            CircleAvatar(
              radius: 65,
              backgroundImage: CachedNetworkImageProvider('$imageServerUrl/${user.avatar}'),
            ),

            /// Loading overlay. Indicador de carga mientras se actualiza el avatar
            if (isLoading)
              Positioned.fill( // Cubre todo el avatar
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withValues(alpha: 0.5),
                  ),
                  child: Center(
                    child: CircularProgressIndicator(color: scheme.onPrimary), // Indicador de carga sobre overlay
                  ),
                ),
              ),

            /// Botón editar
            if (!isLoading)
              Positioned(
                bottom: 0,
                right: 0,
                child: Material(
                  color: scheme.secondary,
                  shape: const CircleBorder(),
                  elevation: 2,
                  child: InkWell(
                    onTap: () => _showAvatarPicker(context, theme, ref),
                    customBorder: const CircleBorder(),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Icon(Icons.camera_alt, color: scheme.onPrimary, size: 19),
                    ),
                  ),
                ),
              ),
          ],
        ),

        const SizedBox(height: 8), // espaciado

        /// Nombre completo
        Text(
          '${user.name} ${user.lastName}',
          style: text.headlineLarge?.copyWith(
            color: scheme.secondary,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        /// Email
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.alternate_email, color: scheme.grey, size: 20),
            const SizedBox(width: 5),
            Text(user.email, style: text.bodyLarge?.copyWith(
                color: scheme.grey,
                fontSize: 17,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),

        const SizedBox(height: 8), // espaciado

        /// Badges info usuario
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            AppPill(
              variant: AppPillVariant.quatertiary,
              size: AppPillSize.sm,
              icon: Icons.work_outline,
              label: l10n.role((user.roles != null && user.roles!.isNotEmpty) ? user.roles!.first.name : ''),
            ),
            if (user.roles != null && user.roles!.isNotEmpty && (user.roles!.first.name == 'admin' || user.roles!.first.name == 'teacher')) ...[ // Solo muestra el departamento si es admin o profesor //! Revisar
              AppPill(
                variant: AppPillVariant.quatertiary,
                size: AppPillSize.sm,
                icon: Icons.people_alt_outlined,
                label: l10n.department(normalizeString(user.department!.name))
              ),
            ],
          ],
        ),
      ],
    );
  }
}