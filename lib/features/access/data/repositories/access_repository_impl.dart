import 'package:dio/dio.dart';
import 'package:frontend_flutter_aulasegura/features/access/data/datasources/access_remote_datasource.dart';
import 'package:frontend_flutter_aulasegura/features/access/data/models/access_check_model.dart';
import 'package:frontend_flutter_aulasegura/features/access/domain/entities/access_check.dart';
import 'package:frontend_flutter_aulasegura/features/access/domain/repositories/access_repository.dart';
import 'package:frontend_flutter_aulasegura/features/access/domain/errors/access_exceptions.dart';

class AccessRepositoryImpl implements AccessRepository {
  final AccessRemoteDataSource remoteDataSource;

  AccessRepositoryImpl({
    required this.remoteDataSource,
  });

  /// Verifica acceso mediante QR
  @override
  Future<AccessCheck> checkQrAccess(String readerCode, String accessMethod) async {
    try {
      final accessCheck = await remoteDataSource.checkQrAccess(readerCode, accessMethod);
      return accessCheck;
    } on DioException catch (e) {
      // Si es 403, el acceso es denegado pero el servidor responde con la estructura
      if (e.response?.statusCode == 403 && e.response?.data != null) {
        return AccessCheckModel.fromJson(e.response!.data as Map<String, dynamic>);
      }
      handleAccessError(e);
    } catch (e) {
      handleAccessError(e);
    }
  }

  /// Maneja errores - deja que DioException se propague para AsyncValue
  Never handleAccessError(Object e) {
    if (e is AccessException) throw e;
    throw e; // Dejar que AsyncValue maneje el error
  }
}
