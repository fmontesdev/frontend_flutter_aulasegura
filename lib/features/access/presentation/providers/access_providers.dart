import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_flutter_aulasegura/features/access/data/repositories/access_repository_impl.dart';
import 'package:frontend_flutter_aulasegura/features/access/data/datasources/access_remote_datasource.dart';
import 'package:frontend_flutter_aulasegura/features/access/domain/entities/access_check.dart';
import 'package:frontend_flutter_aulasegura/features/access/domain/usecases/access_usecases.dart';

// Remote datasource
final accessRemoteDataSourceProvider = Provider<AccessRemoteDataSource>((ref) {
  return AccessRemoteDataSource();
});

// Repositorio
final accessRepositoryProvider = Provider<AccessRepositoryImpl>((ref) {
  return AccessRepositoryImpl(
    remoteDataSource: ref.watch(accessRemoteDataSourceProvider),
  );
});

// Casos de uso
final accessUseCasesProvider = Provider<AccessUseCases>((ref) {
  return AccessUseCases(ref.watch(accessRepositoryProvider));
});

// Notifier para gestionar la verificación de acceso QR
class QrAccessNotifier extends AsyncNotifier<AccessCheck?> {
  @override
  Future<AccessCheck?> build() async {
    return null; // Estado inicial sin datos
  }

  /// Procesa el código QR y verifica el acceso
  Future<void> checkAccess(String readerCode, String accessMethod) async {
    state = const AsyncLoading();
    try {
      final useCases = ref.read(accessUseCasesProvider);
      final result = await useCases.checkQrAccess(readerCode, accessMethod);
      state = AsyncData(result);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }

  /// Resetea el estado
  void reset() {
    state = const AsyncData(null);
  }
}

final qrAccessProvider = AsyncNotifierProvider<QrAccessNotifier, AccessCheck?>(() {
  return QrAccessNotifier();
});
