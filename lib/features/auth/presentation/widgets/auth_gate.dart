import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend_flutter_aulasegura/features/auth/presentation/providers/auth_providers.dart';
import 'package:frontend_flutter_aulasegura/l10n/app_localizations.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final authState = ref.watch(authProvider);

    return authState.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator())
      ),
      error: (error, stack) => Scaffold(
        body: Center(child: Text(l10n.sessionError(error.toString()))) //? Mensaje de error de sesión con internacionalización
      ),
      data: (user) {
        // Realiza la navegación después del build
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          if (user == null) {
            if (context.mounted) GoRouter.of(context).go('/login');
          } else {
            // Prefetch del avatar del usuario para que cargue rápido en home
            final base = dotenv.env['IMAGE_SERVER_URL'] ?? 'http://localhost:8090';
            final url  = '$base/${user.avatar}';
            final provider = CachedNetworkImageProvider(url);
            await precacheImage(provider, context); // Descarga y decodifica en caché la imagen
            if (context.mounted) GoRouter.of(context).go('/home');
          }
        });

        // Mientras tanto, muestra un indicador de carga
        return const Scaffold(
          body: Center(child: CircularProgressIndicator())
        );
      },
    );
  }
}