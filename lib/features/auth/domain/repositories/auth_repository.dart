import 'package:frontend_flutter_aulasegura/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> getUserByEmail(String email);
}