import 'package:frontend_flutter_aulasegura/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<User> refreshToken();
  Future<void> logout();
  Future<User?> getCurrentUser();
}