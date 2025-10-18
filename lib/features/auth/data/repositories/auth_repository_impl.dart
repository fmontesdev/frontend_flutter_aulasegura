import 'package:frontend_flutter_aulasegura/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:frontend_flutter_aulasegura/features/auth/domain/entities/user.dart';
import 'package:frontend_flutter_aulasegura/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;
  AuthRepositoryImpl({required this.localDataSource});

  @override
  Future<User> getUserByEmail(String email) async {
    final userModel = await localDataSource.fetchByEmail(email);
    return userModel;
  }
}