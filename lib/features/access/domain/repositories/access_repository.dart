import 'package:frontend_flutter_aulasegura/features/access/domain/entities/access_check.dart';

abstract class AccessRepository {
  Future<AccessCheck> checkQrAccess(String readerCode, String accessMethod);
}
