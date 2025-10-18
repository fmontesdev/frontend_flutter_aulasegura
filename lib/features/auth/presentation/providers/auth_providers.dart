import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_flutter_aulasegura/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:frontend_flutter_aulasegura/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:frontend_flutter_aulasegura/features/auth/domain/repositories/auth_repository.dart';
import 'package:frontend_flutter_aulasegura/features/auth/domain/usecases/auth_usecases.dart';
import 'package:frontend_flutter_aulasegura/features/auth/domain/entities/user.dart';
import 'package:frontend_flutter_aulasegura/fake_data/users_list.dart' as seed_data;

// DataSource con seed (fake_data)
final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  return AuthLocalDataSource(seed: seed_data.users);
});

// Repositorio
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final ds = ref.watch(authLocalDataSourceProvider);
  return AuthRepositoryImpl(localDataSource: ds);
});

// Casos de uso
final authUseCasesProvider = Provider<AuthUseCases>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return AuthUseCases(repo);
});


// Notifier para manejar el estado de autenticación
class AuthNotifier extends AsyncNotifier<User?> {
  late final AuthUseCases authUseCases;

  @override
  Future<User?> build() async {
    authUseCases = ref.watch(authUseCasesProvider);
    return null; // Sesión vacía al arrancar (no persistimos aún)
  }

  /// Login “fake”, busca por email en el datasource e ignora password
  Future<void> signIn(String email, String password) async {
    state = const AsyncLoading();
    try {
      final user = await authUseCases.getUserByEmail(email.trim());
      // Más adelante podemos validar el password
      state = AsyncData(user);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }

  void signOut() {
    state = const AsyncData(null);
  }
}

final authProvider = AsyncNotifierProvider<AuthNotifier, User?>(() {
  return AuthNotifier();
});
