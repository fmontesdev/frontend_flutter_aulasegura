import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend_flutter_aulasegura/features/auth/presentation/providers/auth_providers.dart';
import 'package:frontend_flutter_aulasegura/core/utils/pretty_dio_logger.dart';

class AppServices {
  /// Una única instancia para toda la app de FlutterSecureStorage
  static final FlutterSecureStorage storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  /// ProviderContainer para acceder a los providers desde fuera del widget tree
  static final ProviderContainer container = ProviderContainer();

  static final Dio dio = _buildDio();

  static Dio _buildDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: dotenv.env['API_BASE_URL']!,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        headers: const {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        // Lanza DioException para códigos >= 400
        validateStatus: (s) => s != null && s >= 200 && s < 400,
      ),
    );

    /// Interceptor
    dio.interceptors.add(
      InterceptorsWrapper(
        // Añade Authorization en cada request si hay accessToken
        onRequest: (options, handler) async {
          final accessToken = await storage.read(key: dotenv.env['ACCESS_KEY']!);
          if (accessToken != null && accessToken.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $accessToken';
          }
          handler.next(options);
        },
        // Si recibe 401, llama al AuthProvider para refrescar el token
        onError: (error, handler) async {
          final requestPath = error.requestOptions.path;
          
          // Solo intentar refresh si es 401 y no es la ruta de refresh/login/change-password
          if (error.response?.statusCode == 401 && 
              !requestPath.contains('/auth/refresh') &&
              !requestPath.contains('/auth/login') &&
              !requestPath.contains('/auth/change-password')) {
            
            try {
              // Llama al AuthProvider para refrescar el token
              // Esto actualiza el estado global y guarda el nuevo token en storage
              await container.read(authProvider.notifier).refreshToken();
              
              // Reintenta la request original con el nuevo token
              final opts = error.requestOptions;
              final newAccessToken = await storage.read(key: dotenv.env['ACCESS_KEY']!);
              
              if (newAccessToken != null) {
                opts.headers['Authorization'] = 'Bearer $newAccessToken';
                final response = await dio.fetch(opts);
                return handler.resolve(response);
              }
            } catch (e) {
              // Si el refresh falla, propaga el error original
            }
          }
          
          // Si no se pudo refrescar, propagar el error original
          handler.next(error);
        },
      ),
    );

    /// Interceptor de logging para debug
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      responseHeader: true,
      requestBody: true,
      responseBody: true,
      error: true,
      compact: true,
      maxWidth: 125,
    ));

    return dio;
  }
}