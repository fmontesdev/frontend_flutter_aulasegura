import 'dart:io';
import 'package:frontend_flutter_aulasegura/features/auth/domain/entities/user.dart';
import 'package:frontend_flutter_aulasegura/features/profile/domain/repositories/avatar_repository.dart';
import 'package:frontend_flutter_aulasegura/features/profile/data/datasources/avatar_remote_datasource.dart';

class AvatarRepositoryImpl implements AvatarRepository {
  final AvatarRemoteDataSource remoteDataSource;

  AvatarRepositoryImpl({required this.remoteDataSource});

  @override
  Future<User> uploadAvatar(File avatarFile, String userId) async {
    try {
      // Obtener extensión del archivo original
      final extension = avatarFile.path.split('.').last.toLowerCase();
      
      // Obtener timestamp actual
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      
      // Construir filename: avatar_{userId}_{timestamp}.{extension}
      final filename = 'avatar_${userId}_$timestamp.$extension';
      
      final userModel = await remoteDataSource.uploadAvatar(avatarFile, filename);
      return userModel;
    } catch (e) {
      rethrow;
    }
  }
}
