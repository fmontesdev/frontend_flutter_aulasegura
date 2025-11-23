import 'dart:io';
import 'package:dio/dio.dart';
import 'package:frontend_flutter_aulasegura/features/auth/data/models/user_model.dart';
import 'package:frontend_flutter_aulasegura/core/utils/app_services.dart';

abstract class AvatarRemoteDataSource {
  Future<UserModel> uploadAvatar(File avatarFile, String filename);
}

class AvatarRemoteDataSourceImpl implements AvatarRemoteDataSource {
  @override
  Future<UserModel> uploadAvatar(File avatarFile, String filename) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        avatarFile.path,
      ),
      'filename': filename,
    });

    final response = await AppServices.dio.post(
      '/users/upload-avatar',
      data: formData,
    );

    return UserModel.fromJson(response.data);
  }
}
