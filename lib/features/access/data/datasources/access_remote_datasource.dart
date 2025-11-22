import 'package:frontend_flutter_aulasegura/core/utils/app_services.dart';
import 'package:frontend_flutter_aulasegura/features/access/data/models/access_check_model.dart';

class AccessRemoteDataSource {
  /// Llama a la API para verificar acceso QR
  Future<AccessCheckModel> checkQrAccess(String readerCode, String accessMethod) async {
    final response = await AppServices.dio.post(
      '/access/qrcheck',
      data: {
        'readerCode': readerCode,
        'accessMethod': accessMethod,
      },
    );
    return AccessCheckModel.fromJson(response.data);
  }
}
