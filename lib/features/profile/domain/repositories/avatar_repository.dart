import 'dart:io';
import 'package:frontend_flutter_aulasegura/features/auth/domain/entities/user.dart';

abstract class AvatarRepository {
  Future<User> uploadAvatar(File avatarFile, String userId);
}
