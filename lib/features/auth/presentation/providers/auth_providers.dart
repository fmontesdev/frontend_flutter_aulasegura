import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_flutter_aulasegura/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:frontend_flutter_aulasegura/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:frontend_flutter_aulasegura/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:frontend_flutter_aulasegura/features/auth/domain/repositories/auth_repository.dart';
import 'package:frontend_flutter_aulasegura/features/auth/domain/usecases/auth_usecases.dart';
import 'package:frontend_flutter_aulasegura/features/auth/domain/entities/user.dart';

// Remote DataSource
final authRemoteDSProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSource();
});

// Local DataSource
final authLocalDSProvider = Provider<AuthLocalDataSource>((ref) {
  return AuthLocalDataSource();
});

// Repositorio
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remote = ref.watch(authRemoteDSProvider);
  final local = ref.watch(authLocalDSProvider);
  return AuthRepositoryImpl(
    remoteDataSource: remote,
    localDataSource: local,
  );
});

// Casos de uso
final authUseCasesProvider = Provider<AuthUseCases>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return AuthUseCases(repo);
});


// Notifier para manejar el estado de autenticación
class AuthNotifier extends AsyncNotifier<User?> {
  @override
  Future<User?> build() async {
    final authUseCases = ref.watch(authUseCasesProvider);
    try {
      final user = await authUseCases.getCurrentUser();
      return user;
    } catch (_) {
      await authUseCases.logout();
      return null;
    }
  }

  /// Login
  Future<void> signIn(String email, String password) async {
    state = const AsyncLoading();
    try {
      final authUseCases = ref.read(authUseCasesProvider);
      final user = await authUseCases.login(email, password);
      state = AsyncData(user);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }

  /// Actualiza el accessToken usando el refreshToken guardado
  Future<void> refreshToken() async {
    try {
      final authUseCases = ref.read(authUseCasesProvider);
      final user = await authUseCases.refreshToken();
      state = AsyncData(user);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }

  /// Logout
  Future<void> signOut() async {
    final authUseCases = ref.read(authUseCasesProvider);
    await authUseCases.logout();
    state = const AsyncData(null);
  }

  /// Obtiene el usuario autenticado
  Future<User?> getCurrentUser() async {
    final authUseCases = ref.read(authUseCasesProvider);
    return await authUseCases.getCurrentUser();
  }

  /// Cambiar la contraseña
  Future<void> changePassword(String oldPassword, String newPassword) async {
    try {
      final authUseCases = ref.read(authUseCasesProvider);
      await authUseCases.changePassword(oldPassword, newPassword);
    } catch (error) {
      rethrow; // Relanza el error para que sea capturado en la UI
    }
  }

  /// Actualiza el usuario en el estado (usado después de cambiar avatar)
  void updateUser(User user) {
    state = AsyncData(user);
  }
}

final authProvider = AsyncNotifierProvider<AuthNotifier, User?>(() {
  return AuthNotifier();
});
