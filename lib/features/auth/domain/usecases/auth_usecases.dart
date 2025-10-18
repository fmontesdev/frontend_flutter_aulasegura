import 'package:frontend_flutter_aulasegura/features/auth/domain/entities/user.dart';
import 'package:frontend_flutter_aulasegura/features/auth/domain/repositories/auth_repository.dart';

class AuthUseCases {
  final Future<User> Function(String email) getUserByEmail;

  AuthUseCases(AuthRepository repo)
    : getUserByEmail = repo.getUserByEmail;
}