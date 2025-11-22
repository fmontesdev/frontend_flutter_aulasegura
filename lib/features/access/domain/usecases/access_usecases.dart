import 'package:frontend_flutter_aulasegura/features/access/domain/entities/access_check.dart';
import 'package:frontend_flutter_aulasegura/features/access/domain/repositories/access_repository.dart';

class AccessUseCases {
  final Future<AccessCheck> Function(String readerCode, String accessMethod) checkQrAccess;

  AccessUseCases(AccessRepository repo)
      : checkQrAccess = repo.checkQrAccess;
}
