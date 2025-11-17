import 'package:frontend_flutter_aulasegura/features/auth/domain/entities/user.dart';
import 'package:frontend_flutter_aulasegura/features/auth/domain/repositories/auth_repository.dart';

class AuthUseCases {
  final Future<User> Function(String email, String password) login;
  final Future<User> Function() refreshToken;
  final Future<void> Function() logout;
  final Future<User?> Function() getCurrentUser;
  final Future<void> Function(String oldPassword, String newPassword) changePassword;

  AuthUseCases(AuthRepository repo)
      : login = repo.login,
      refreshToken = repo.refreshToken,
      logout = repo.logout,
      getCurrentUser = repo.getCurrentUser,
      changePassword = repo.changePassword;
}