import 'package:frontend_flutter_aulasegura/core/utils/app_services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthLocalDataSource {
  /// Obtiene accessToken guardado en secure storage
  Future<String?> getAccessToken() async {
    return AppServices.storage.read(key: dotenv.env['ACCESS_KEY']!);
  }

  /// Obtiene refreshToken guardado en secure storage
  Future<String?> getRefreshToken() async {
    return AppServices.storage.read(key: dotenv.env['REFRESH_KEY']!);
  }

  /// Guarda accessToken en secure storage
  Future<void> saveAccessToken(String token) async {
    await AppServices.storage.write(key: dotenv.env['ACCESS_KEY']!, value: token);
  }

  /// Guarda refreshToken en secure storage
  Future<void> saveRefreshToken(String token) async {
    await AppServices.storage.write(key: dotenv.env['REFRESH_KEY']!, value: token);
  }

  /// Elimina tokens desde secure storage
  Future<void> clearTokens() async {
    await AppServices.storage.delete(key: dotenv.env['ACCESS_KEY']!);
    await AppServices.storage.delete(key: dotenv.env['REFRESH_KEY']!);
  }
}