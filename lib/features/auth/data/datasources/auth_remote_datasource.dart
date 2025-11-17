import 'package:frontend_flutter_aulasegura/core/utils/app_services.dart';
import 'package:frontend_flutter_aulasegura/features/auth/data/models/user_model.dart';

class AuthRemoteDataSource {
  /// Llama a la API para login
  Future<UserModel> login(String email, String password) async {
    final response = await AppServices.dio.post(
      '/auth/login',
      data: {'email': email, 'password': password},
    );
    return UserModel.fromJson(response.data);
  }

  /// Llama a la API para actualizar el accessToken a partir del refreshToken
  Future<UserModel> refreshToken(String refreshToken) async {
    final response = await AppServices.dio.post(
      '/auth/refresh',
      data: {'refreshToken': refreshToken},
    );
    return UserModel.fromJson(response.data);
  }
  
  /// Llama a la API para logout
  Future<void> logout(String refreshToken) async {
    await AppServices.dio.post(
      '/auth/logout',
      data: {'refreshToken': refreshToken}
    );
  }

  /// Llama a la API para obtener el usuario autenticado
  Future<UserModel> getCurrentUser() async {
    final response = await AppServices.dio.get(
      '/auth/me'
    );
    return UserModel.fromJson(response.data);
  }
}