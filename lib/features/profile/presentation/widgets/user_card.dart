import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend_flutter_aulasegura/l10n/app_localizations.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';
import 'package:frontend_flutter_aulasegura/features/auth/domain/entities/user.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_card.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_pill.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_button.dart';
import 'package:frontend_flutter_aulasegura/core/utils/normalize_string.dart';

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final text = theme.textTheme;
    final l10n = AppLocalizations.of(context)!;
    final imageServerUrl = dotenv.env['IMAGE_SERVER_URL'] ?? 'http://localhost:8090';

    return AppCard(
      alignment: CrossAxisAlignment.center,
      children: [

        /// Avatar
        CircleAvatar(
          radius: 65,
          backgroundImage: CachedNetworkImageProvider('$imageServerUrl/${user.avatar}'),
        ),

        const SizedBox(height: 12), // espaciado

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
              label: l10n.role(user.role.name)
            ),
            if (user.role.name == 'admin' || user.role.name == 'teacher') ...[ // Solo muestra el departamento si es admin o profesor
              AppPill(
                variant: AppPillVariant.quatertiary,
                size: AppPillSize.sm,
                icon: Icons.people_alt_outlined,
                label: l10n.department(normalizeString(user.department!.name))
              ),
            ],
          ],
        ),

        const SizedBox(height: 22), // espaciado

        /// Botón logout
        FractionallySizedBox(
          widthFactor: 0.65,
          child: AppButton(
            variant: AppButtonVariant.lightRed,
            size: AppButtonSize.sm,
            label: l10n.logout,
            icon: Icons.logout,
            border: true,
            overlayColor: true,
            onPressed: () => GoRouter.of(context).go('/login'),
          ),
        ),
      ],
    );
  }
}