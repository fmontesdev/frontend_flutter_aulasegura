import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_flutter_aulasegura/features/auth/presentation/providers/auth_providers.dart';
import 'package:frontend_flutter_aulasegura/features/profile/domain/services/avatar_service.dart';
import 'package:frontend_flutter_aulasegura/features/profile/data/datasources/avatar_remote_datasource.dart';
import 'package:frontend_flutter_aulasegura/features/profile/data/repositories/avatar_repository_impl.dart';
import 'package:frontend_flutter_aulasegura/features/profile/domain/repositories/avatar_repository.dart';
import 'package:frontend_flutter_aulasegura/features/profile/domain/usecases/avatar_usecases.dart';

// Remote DataSource
final avatarRemoteDSProvider = Provider<AvatarRemoteDataSource>((ref) {
  return AvatarRemoteDataSourceImpl();
});

// Repositorio
final avatarRepositoryProvider = Provider<AvatarRepository>((ref) {
  final remote = ref.watch(avatarRemoteDSProvider);
  return AvatarRepositoryImpl(remoteDataSource: remote);
});

// Casos de uso
final avatarUseCasesProvider = Provider<AvatarUseCases>((ref) {
  final repo = ref.watch(avatarRepositoryProvider);
  return AvatarUseCases(repository: repo);
});

class AvatarUpdate {
  final Ref ref;

  AvatarUpdate(this.ref);

  /// Actualiza el avatar del usuario
  Future<void> uploadAvatar(File avatarFile) async {
    // Obtener userId del usuario autenticado
    final currentUser = ref.read(authProvider).value;
    if (currentUser == null) {
      throw Exception('userNotAuthenticated');
    }
    
    final avatarUseCases = ref.read(avatarUseCasesProvider);
    final updatedUser = await avatarUseCases(avatarFile, currentUser.id);
    
    // Actualiza el provider de auth con el nuevo usuario
    ref.read(authProvider.notifier).updateUser(updatedUser);
  }
}

// Provider para actualizar el avatar
final avatarUploadProvider = Provider<AvatarUpdate>((ref) {
  return AvatarUpdate(ref);
});

// Servicio de avatar
final avatarServiceProvider = Provider<AvatarService>((ref) {
  return AvatarService();
});