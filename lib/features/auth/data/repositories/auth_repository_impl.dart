import 'package:dio/dio.dart';
import 'package:frontend_flutter_aulasegura/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:frontend_flutter_aulasegura/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:frontend_flutter_aulasegura/features/auth/domain/entities/user.dart';
import 'package:frontend_flutter_aulasegura/features/auth/domain/repositories/auth_repository.dart';
import 'package:frontend_flutter_aulasegura/features/auth/domain/errors/auth_exceptions.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource
  });

  /// Login
  @override
  Future<User> login(String email, String password) async {
    try {
      // Llama a la API
      final userModel = await remoteDataSource.login(email, password);
      
      // Guarda token en secure storage o lanza excepción
      if (userModel.accessToken == null || userModel.refreshToken == null) {
        throw const TokenNotFoundException();
      }
      await localDataSource.saveAccessToken(userModel.accessToken!);
      await localDataSource.saveRefreshToken(userModel.refreshToken!);
      
      // Devuelve el usuario
      return userModel;
    } catch (e) {
      handleAuthError(e);
    }
  }

  /// Extrae el mensaje de error del backend
  String? _extractErrorMessage(DioException e) {
    final data = e.response?.data;
    return data is Map<String, dynamic> ? data['message'] as String? : null;
  }

  /// Intenta refrescar el accessToken usando el refreshToken guardado
  @override
  Future<User> refreshToken() async {
    try {
      // Obtiene refreshToken guardado en secure storage
      final refreshToken = await localDataSource.getRefreshToken();
      if (refreshToken == null) {
        throw const TokenNotFoundException();
      }

      // Llama a la API
      final userModel = await remoteDataSource.refreshToken(refreshToken);
      
      // Guarda nuevo accessToken en secure storage
      if (userModel.accessToken == null) {
        throw const TokenNotFoundException();
      }
      await localDataSource.saveAccessToken(userModel.accessToken!);
      
      // Devuelve el usuario
      return userModel;
    } catch (e) {
      handleAuthError(e);
    }
  }

  /// Logout
  @override
  Future<void> logout() async {
    try {
      // Obtiene refreshToken guardado en secure storage
      final refreshToken = await localDataSource.getRefreshToken();
      if (refreshToken == null) {
        throw const TokenNotFoundException();
      }

      // Llama a la API
      await remoteDataSource.logout(refreshToken);
    } catch (e) {
      handleAuthError(e);
    } finally {
      // Asegura la limpieza de tokens del secure storage aunque falle el logout remoto
      await localDataSource.clearTokens();
    }
  }
  
  /// Obtiene el usuario autenticado
  @override
  Future<User?> getCurrentUser() async {
    try {
      // Obtiene accessToken guardado en secure storage
      final token = await localDataSource.getAccessToken();
      if (token == null) {
        return null;
      }

      // Llama a la API
      return await remoteDataSource.getCurrentUser();
    } catch (e) {
      return null;
    }
  }

  /// Maneja errores y los transforma en excepciones de dominio
  Never handleAuthError(Object e) {
    if (e is AuthException) throw e;
    
    if (e is DioException) {
      final message = _extractErrorMessage(e);
      
      if (e.response?.statusCode == 401 || e.response?.statusCode == 404) {
        // Normaliza el mensaje reemplazando espacios por guiones bajos para ICU select
        throw InvalidCredentialsException(message?.replaceAll(' ', '_') ?? 'Credenciales inválidas');
      }
      
      throw NetworkException(message ?? 'Error de conexión');
    }
    
    throw UnexpectedException('Error inesperado: $e');
  }
}