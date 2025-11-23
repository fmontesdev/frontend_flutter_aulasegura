import 'dart:io';
import 'package:frontend_flutter_aulasegura/features/auth/domain/entities/user.dart';
import 'package:frontend_flutter_aulasegura/features/profile/domain/repositories/avatar_repository.dart';

class AvatarUseCases {
  final AvatarRepository repository;

  AvatarUseCases({required this.repository});

  Future<User> call(File avatarFile, String userId) async {
    return await repository.uploadAvatar(avatarFile, userId);
  }
}
